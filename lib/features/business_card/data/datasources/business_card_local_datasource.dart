import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/business_card_model.dart';

/// Business Card Local Datasource
/// Handles local storage using SQLite for mobile and Hive for web
abstract class BusinessCardLocalDatasource {
  Future<List<BusinessCardModel>> getAllCards();
  Future<BusinessCardModel?> getCardById(String id);
  Future<void> addCard(BusinessCardModel card);
  Future<void> updateCard(BusinessCardModel card);
  Future<void> deleteCard(String id);
  Future<List<BusinessCardModel>> searchCards(String query);
}

/// SQLite implementation for mobile platforms
class BusinessCardSQLiteDatasource implements BusinessCardLocalDatasource {
  static const String _tableName = 'business_cards';
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'business_cards.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            title TEXT,
            company TEXT,
            email TEXT,
            phone TEXT,
            website TEXT,
            address TEXT,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Future<List<BusinessCardModel>> getAllCards() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return BusinessCardModel.fromJson(maps[i]);
    });
  }

  @override
  Future<BusinessCardModel?> getCardById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return BusinessCardModel.fromJson(maps.first);
  }

  @override
  Future<void> addCard(BusinessCardModel card) async {
    final db = await database;
    await db.insert(
      _tableName,
      card.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateCard(BusinessCardModel card) async {
    final db = await database;
    await db.update(
      _tableName,
      card.toJson(),
      where: 'id = ?',
      whereArgs: [card.modelId],
    );
  }

  @override
  Future<void> deleteCard(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<BusinessCardModel>> searchCards(String query) async {
    final db = await database;
    final searchQuery = '%$query%';
    
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: '''
        name LIKE ? OR 
        title LIKE ? OR 
        company LIKE ? OR 
        email LIKE ? OR 
        phone LIKE ?
      ''',
      whereArgs: [searchQuery, searchQuery, searchQuery, searchQuery, searchQuery],
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return BusinessCardModel.fromJson(maps[i]);
    });
  }
}

/// Hive implementation for web platform
class BusinessCardHiveDatasource implements BusinessCardLocalDatasource {
  static const String _boxName = 'business_cards';
  Box<BusinessCardModel>? _box;

  Future<Box<BusinessCardModel>> get box async {
    if (_box != null && _box!.isOpen) return _box!;
    _box = await Hive.openBox<BusinessCardModel>(_boxName);
    return _box!;
  }

  @override
  Future<List<BusinessCardModel>> getAllCards() async {
    final b = await box;
    final cards = b.values.toList();
    cards.sort((a, b) => b.modelCreatedAt.compareTo(a.modelCreatedAt));
    return cards;
  }

  @override
  Future<BusinessCardModel?> getCardById(String id) async {
    final b = await box;
    return b.values.firstWhere(
      (card) => card.modelId == id,
      orElse: () => throw Exception('Card not found'),
    );
  }

  @override
  Future<void> addCard(BusinessCardModel card) async {
    final b = await box;
    await b.put(card.modelId, card);
  }

  @override
  Future<void> updateCard(BusinessCardModel card) async {
    final b = await box;
    await b.put(card.modelId, card);
  }

  @override
  Future<void> deleteCard(String id) async {
    final b = await box;
    await b.delete(id);
  }

  @override
  Future<List<BusinessCardModel>> searchCards(String query) async {
    final b = await box;
    final lowerQuery = query.toLowerCase();
    
    final results = b.values.where((card) {
      return card.modelName.toLowerCase().contains(lowerQuery) ||
          (card.modelTitle?.toLowerCase().contains(lowerQuery) ?? false) ||
          (card.modelCompany?.toLowerCase().contains(lowerQuery) ?? false) ||
          (card.modelEmail?.toLowerCase().contains(lowerQuery) ?? false) ||
          (card.modelPhone?.contains(query) ?? false);
    }).toList();

    results.sort((a, b) => b.modelCreatedAt.compareTo(a.modelCreatedAt));
    return results;
  }
}

/// Factory to get the appropriate datasource based on platform
class BusinessCardDatasourceFactory {
  static BusinessCardLocalDatasource create() {
    if (kIsWeb) {
      return BusinessCardHiveDatasource();
    } else {
      return BusinessCardSQLiteDatasource();
    }
  }
}

