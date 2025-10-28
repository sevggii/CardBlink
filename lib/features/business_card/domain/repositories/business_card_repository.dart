import '../entities/business_card.dart';

/// Business Card Repository Interface
/// Defines the contract for business card data operations
abstract class BusinessCardRepository {
  /// Get all business cards
  Future<List<BusinessCard>> getAllCards();

  /// Get a business card by ID
  Future<BusinessCard?> getCardById(String id);

  /// Add a new business card
  Future<void> addCard(BusinessCard card);

  /// Update an existing business card
  Future<void> updateCard(BusinessCard card);

  /// Delete a business card
  Future<void> deleteCard(String id);

  /// Search cards by query
  Future<List<BusinessCard>> searchCards(String query);

  /// Check if a card with similar information already exists
  Future<BusinessCard?> findSimilarCard(BusinessCard card);

  /// Export all cards to CSV format
  Future<String> exportToCSV();

  /// Export all cards to Excel format
  Future<List<int>> exportToExcel();
}

