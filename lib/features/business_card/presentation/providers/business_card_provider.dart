import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/ocr_service.dart';
import '../../../../core/services/text_parser.dart';
import '../../../../core/utils/id_generator.dart';
import '../../data/datasources/business_card_local_datasource.dart';
import '../../data/repositories/business_card_repository_impl.dart';
import '../../domain/entities/business_card.dart';
import '../../domain/repositories/business_card_repository.dart';

// Repository Provider
final businessCardRepositoryProvider = Provider<BusinessCardRepository>((ref) {
  final datasource = BusinessCardDatasourceFactory.create();
  return BusinessCardRepositoryImpl(datasource);
});

// OCR Service Provider
final ocrServiceProvider = Provider<OCRService>((ref) {
  return OCRServiceFactory.create();
});

// Text Parser Provider
final textParserProvider = Provider<TextParser>((ref) {
  return TextParser();
});

// Business Cards List Provider
final businessCardsProvider = StreamProvider<List<BusinessCard>>((ref) async* {
  final repository = ref.watch(businessCardRepositoryProvider);
  
  // Initial load
  yield await repository.getAllCards();
  
  // For simplicity, we'll refresh when state changes
  // In a real app, you might want to use a more sophisticated approach
});

// Business Card Notifier
class BusinessCardNotifier extends StateNotifier<AsyncValue<void>> {
  final BusinessCardRepository _repository;
  final OCRService _ocrService;
  final TextParser _textParser;

  BusinessCardNotifier(
    this._repository,
    this._ocrService,
    this._textParser,
  ) : super(const AsyncValue.data(null));

  /// Scan a business card from image
  Future<BusinessCard?> scanCard(XFile image) async {
    state = const AsyncValue.loading();
    
    try {
      // Perform OCR
      final text = await _ocrService.recognizeText(image);
      
      // Parse the text
      var card = _textParser.parseBusinessCard(text);
      
      // Generate ID
      card = card.copyWith(id: IDGenerator.generateWithTimestamp());
      
      // Check for duplicates
      final similarCard = await _repository.findSimilarCard(card);
      
      if (similarCard != null) {
        state = const AsyncValue.data(null);
        return null; // Duplicate found
      }
      
      // Save the card
      await _repository.addCard(card);
      
      state = const AsyncValue.data(null);
      return card;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Add a card manually
  Future<void> addCard(BusinessCard card) async {
    state = const AsyncValue.loading();
    
    try {
      var cardWithId = card;
      if (card.id == null) {
        cardWithId = card.copyWith(id: IDGenerator.generateWithTimestamp());
      }
      
      await _repository.addCard(cardWithId);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Update a card
  Future<void> updateCard(BusinessCard card) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.updateCard(card);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Delete a card
  Future<void> deleteCard(String id) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.deleteCard(id);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Export cards to CSV
  Future<String> exportToCSV() async {
    return await _repository.exportToCSV();
  }

  /// Export cards to Excel
  Future<List<int>> exportToExcel() async {
    return await _repository.exportToExcel();
  }

  /// Search cards
  Future<List<BusinessCard>> searchCards(String query) async {
    return await _repository.searchCards(query);
  }
}

// Business Card Notifier Provider
final businessCardNotifierProvider =
    StateNotifierProvider<BusinessCardNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(businessCardRepositoryProvider);
  final ocrService = ref.watch(ocrServiceProvider);
  final textParser = ref.watch(textParserProvider);
  
  return BusinessCardNotifier(repository, ocrService, textParser);
});

// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered Cards Provider
final filteredCardsProvider = FutureProvider<List<BusinessCard>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final repository = ref.watch(businessCardRepositoryProvider);
  
  if (query.isEmpty) {
    return await repository.getAllCards();
  } else {
    return await repository.searchCards(query);
  }
});

