/// Application Constants
class AppConstants {
  // App Info
  static const String appName = 'CardBlink';
  static const String appVersion = '1.0.0';
  static const String appDescription = 
      'Smart Business Card Scanner with OCR';

  // Privacy Policy
  static const String privacyTitle = 'Privacy & Data Usage';
  static const String privacyMessageEN = '''
CardBlink respects your privacy and is designed with data protection in mind.

• This app only processes business card images for OCR text recognition
• All OCR processing happens locally on your device
• No data is sent to external servers
• All business card information is stored locally on your device
• You have full control over your data and can delete it at any time

By continuing to use this app, you acknowledge that you will only scan business cards that you have received with consent and for legitimate business purposes.
''';

  static const String privacyMessageTR = '''
CardBlink gizliliğinize saygı duyar ve veri koruma düşünülerek tasarlanmıştır.

• Bu uygulama yalnızca OCR metin tanıma için iş kartı görüntülerini işler
• Tüm OCR işlemleri cihazınızda yerel olarak gerçekleşir
• Harici sunuculara hiçbir veri gönderilmez
• Tüm iş kartı bilgileri cihazınızda yerel olarak saklanır
• Verileriniz üzerinde tam kontrole sahipsiniz ve istediğiniz zaman silebilirsiniz

Bu uygulamayı kullanmaya devam ederek, yalnızca izinle aldığınız ve meşru iş amaçları için iş kartlarını tarayacağınızı kabul etmiş olursunuz.
''';

  // File Export
  static const String exportFileNameCSV = 'business_cards_export.csv';
  static const String exportFileNameExcel = 'business_cards_export.xlsx';

  // Hive
  static const String hiveBoxName = 'business_cards';

  // SQLite
  static const String sqliteDBName = 'business_cards.db';
  static const String sqliteTableName = 'business_cards';
}

