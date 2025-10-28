import '../../features/business_card/domain/entities/business_card.dart';

/// Text Parser Service
/// Parses OCR text and extracts business card information
class TextParser {
  /// Parse OCR text and extract business card information
  BusinessCard parseBusinessCard(String text) {
    final lines = text.split('\n').where((line) => line.trim().isNotEmpty).toList();
    
    String name = '';
    String? title;
    String? company;
    String? email;
    String? phone;
    String? website;
    String? address;

    final List<String> addressParts = [];

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      
      // Extract email
      if (email == null && _isEmail(line)) {
        email = _extractEmail(line);
        continue;
      }

      // Extract phone
      if (phone == null && _isPhone(line)) {
        phone = _extractPhone(line);
        continue;
      }

      // Extract website
      if (website == null && _isWebsite(line)) {
        website = _extractWebsite(line);
        continue;
      }

      // First non-contact line is likely the name
      if (name.isEmpty && !_isContactInfo(line)) {
        name = line;
        continue;
      }

      // Second non-contact line might be title
      if (name.isNotEmpty && title == null && !_isContactInfo(line) && i < 3) {
        title = line;
        continue;
      }

      // Third non-contact line might be company
      if (name.isNotEmpty && company == null && !_isContactInfo(line) && i < 4) {
        company = line;
        continue;
      }

      // Remaining lines might be address
      if (!_isContactInfo(line)) {
        addressParts.add(line);
      }
    }

    // Combine address parts
    if (addressParts.isNotEmpty) {
      address = addressParts.join(', ');
    }

    // If name is still empty, use first line
    if (name.isEmpty && lines.isNotEmpty) {
      name = lines[0];
    }

    return BusinessCard(
      name: name.isEmpty ? 'Unknown' : name,
      title: title,
      company: company,
      email: email,
      phone: phone,
      website: website,
      address: address,
      createdAt: DateTime.now(),
    );
  }

  bool _isContactInfo(String text) {
    return _isEmail(text) || _isPhone(text) || _isWebsite(text);
  }

  bool _isEmail(String text) {
    final emailRegex = RegExp(
      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
    );
    return emailRegex.hasMatch(text);
  }

  String _extractEmail(String text) {
    final emailRegex = RegExp(
      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
    );
    final match = emailRegex.firstMatch(text);
    return match?.group(0) ?? text;
  }

  bool _isPhone(String text) {
    // Remove common separators
    final cleaned = text.replaceAll(RegExp(r'[\s\-\(\)\.]'), '');
    
    // Check if it contains mostly digits and has phone-like length
    final digitCount = cleaned.replaceAll(RegExp(r'[^\d]'), '').length;
    
    return digitCount >= 7 && digitCount <= 15 && 
           text.contains(RegExp(r'\d'));
  }

  String _extractPhone(String text) {
    // Clean up common phone number formats
    return text.trim();
  }

  bool _isWebsite(String text) {
    final websiteRegex = RegExp(
      r'\b(?:https?://)?(?:www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?\b',
    );
    return websiteRegex.hasMatch(text.toLowerCase());
  }

  String _extractWebsite(String text) {
    final websiteRegex = RegExp(
      r'\b(?:https?://)?(?:www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?\b',
    );
    final match = websiteRegex.firstMatch(text.toLowerCase());
    return match?.group(0) ?? text;
  }
}

