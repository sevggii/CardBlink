import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import '../../domain/entities/business_card.dart';
import '../../domain/repositories/business_card_repository.dart';
import '../datasources/business_card_local_datasource.dart';
import '../models/business_card_model.dart';

/// Business Card Repository Implementation
class BusinessCardRepositoryImpl implements BusinessCardRepository {
  final BusinessCardLocalDatasource _datasource;

  BusinessCardRepositoryImpl(this._datasource);

  @override
  Future<List<BusinessCard>> getAllCards() async {
    final models = await _datasource.getAllCards();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<BusinessCard?> getCardById(String id) async {
    final model = await _datasource.getCardById(id);
    return model?.toEntity();
  }

  @override
  Future<void> addCard(BusinessCard card) async {
    final model = BusinessCardModel.fromEntity(card);
    await _datasource.addCard(model);
  }

  @override
  Future<void> updateCard(BusinessCard card) async {
    final model = BusinessCardModel.fromEntity(card);
    await _datasource.updateCard(model);
  }

  @override
  Future<void> deleteCard(String id) async {
    await _datasource.deleteCard(id);
  }

  @override
  Future<List<BusinessCard>> searchCards(String query) async {
    final models = await _datasource.searchCards(query);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<BusinessCard?> findSimilarCard(BusinessCard card) async {
    final allCards = await getAllCards();
    
    for (final existingCard in allCards) {
      if (card.isSimilarTo(existingCard)) {
        return existingCard;
      }
    }
    
    return null;
  }

  @override
  Future<String> exportToCSV() async {
    final cards = await getAllCards();
    
    final List<List<dynamic>> rows = [
      ['Name', 'Title', 'Company', 'Email', 'Phone', 'Website', 'Address', 'Created At'],
    ];

    for (final card in cards) {
      rows.add([
        card.name,
        card.title ?? '',
        card.company ?? '',
        card.email ?? '',
        card.phone ?? '',
        card.website ?? '',
        card.address ?? '',
        card.createdAt.toIso8601String(),
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }

  @override
  Future<List<int>> exportToExcel() async {
    final cards = await getAllCards();
    
    final excel = Excel.createExcel();
    final sheet = excel['Business Cards'];

    // Header row
    sheet.appendRow([
      const TextCellValue('Name'),
      const TextCellValue('Title'),
      const TextCellValue('Company'),
      const TextCellValue('Email'),
      const TextCellValue('Phone'),
      const TextCellValue('Website'),
      const TextCellValue('Address'),
      const TextCellValue('Created At'),
    ]);

    // Data rows
    for (final card in cards) {
      sheet.appendRow([
        TextCellValue(card.name),
        TextCellValue(card.title ?? ''),
        TextCellValue(card.company ?? ''),
        TextCellValue(card.email ?? ''),
        TextCellValue(card.phone ?? ''),
        TextCellValue(card.website ?? ''),
        TextCellValue(card.address ?? ''),
        TextCellValue(card.createdAt.toIso8601String()),
      ]);
    }

    return excel.encode()!;
  }
}

