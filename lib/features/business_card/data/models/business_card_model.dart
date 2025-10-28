import 'package:hive/hive.dart';
import '../../domain/entities/business_card.dart';

part 'business_card_model.g.dart';

/// Business Card Model
/// Data layer representation with serialization support
@HiveType(typeId: 0)
class BusinessCardModel extends BusinessCard {
  @HiveField(0)
  final String? modelId;

  @HiveField(1)
  final String modelName;

  @HiveField(2)
  final String? modelTitle;

  @HiveField(3)
  final String? modelCompany;

  @HiveField(4)
  final String? modelEmail;

  @HiveField(5)
  final String? modelPhone;

  @HiveField(6)
  final String? modelWebsite;

  @HiveField(7)
  final String? modelAddress;

  @HiveField(8)
  final DateTime modelCreatedAt;

  const BusinessCardModel({
    this.modelId,
    required this.modelName,
    this.modelTitle,
    this.modelCompany,
    this.modelEmail,
    this.modelPhone,
    this.modelWebsite,
    this.modelAddress,
    required this.modelCreatedAt,
  }) : super(
          id: modelId,
          name: modelName,
          title: modelTitle,
          company: modelCompany,
          email: modelEmail,
          phone: modelPhone,
          website: modelWebsite,
          address: modelAddress,
          createdAt: modelCreatedAt,
        );

  /// Convert from Entity to Model
  factory BusinessCardModel.fromEntity(BusinessCard card) {
    return BusinessCardModel(
      modelId: card.id,
      modelName: card.name,
      modelTitle: card.title,
      modelCompany: card.company,
      modelEmail: card.email,
      modelPhone: card.phone,
      modelWebsite: card.website,
      modelAddress: card.address,
      modelCreatedAt: card.createdAt,
    );
  }

  /// Convert from JSON (for SQLite)
  factory BusinessCardModel.fromJson(Map<String, dynamic> json) {
    return BusinessCardModel(
      modelId: json['id'] as String?,
      modelName: json['name'] as String,
      modelTitle: json['title'] as String?,
      modelCompany: json['company'] as String?,
      modelEmail: json['email'] as String?,
      modelPhone: json['phone'] as String?,
      modelWebsite: json['website'] as String?,
      modelAddress: json['address'] as String?,
      modelCreatedAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Convert to JSON (for SQLite)
  Map<String, dynamic> toJson() {
    return {
      'id': modelId,
      'name': modelName,
      'title': modelTitle,
      'company': modelCompany,
      'email': modelEmail,
      'phone': modelPhone,
      'website': modelWebsite,
      'address': modelAddress,
      'createdAt': modelCreatedAt.toIso8601String(),
    };
  }

  /// Convert to Entity
  BusinessCard toEntity() {
    return BusinessCard(
      id: modelId,
      name: modelName,
      title: modelTitle,
      company: modelCompany,
      email: modelEmail,
      phone: modelPhone,
      website: modelWebsite,
      address: modelAddress,
      createdAt: modelCreatedAt,
    );
  }
}

