import 'package:equatable/equatable.dart';

/// Business Card Entity
/// Represents a business card with all its information
class BusinessCard extends Equatable {
  final String? id;
  final String name;
  final String? title;
  final String? company;
  final String? email;
  final String? phone;
  final String? website;
  final String? address;
  final DateTime createdAt;

  const BusinessCard({
    this.id,
    required this.name,
    this.title,
    this.company,
    this.email,
    this.phone,
    this.website,
    this.address,
    required this.createdAt,
  });

  /// Create a copy of this entity with some fields replaced
  BusinessCard copyWith({
    String? id,
    String? name,
    String? title,
    String? company,
    String? email,
    String? phone,
    String? website,
    String? address,
    DateTime? createdAt,
  }) {
    return BusinessCard(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        title,
        company,
        email,
        phone,
        website,
        address,
        createdAt,
      ];

  /// Check if this card is similar to another (for duplicate detection)
  bool isSimilarTo(BusinessCard other) {
    // Compare by name and at least one contact method
    final nameMatch = name.toLowerCase() == other.name.toLowerCase();
    
    if (!nameMatch) return false;

    // If names match, check if any contact info matches
    final emailMatch = email != null && 
                      other.email != null && 
                      email!.toLowerCase() == other.email!.toLowerCase();
    
    final phoneMatch = phone != null && 
                      other.phone != null && 
                      _normalizePhone(phone!) == _normalizePhone(other.phone!);
    
    return emailMatch || phoneMatch;
  }

  /// Normalize phone number for comparison (remove spaces, dashes, parentheses)
  String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  }
}

