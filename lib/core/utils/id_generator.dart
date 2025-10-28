import 'dart:math';

/// ID Generator Utility
class IDGenerator {
  static const String _chars = 
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static final Random _random = Random();

  /// Generate a random ID
  static String generate({int length = 16}) {
    return List.generate(
      length,
      (index) => _chars[_random.nextInt(_chars.length)],
    ).join();
  }

  /// Generate a timestamp-based ID
  static String generateWithTimestamp() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomPart = generate(length: 8);
    return '${timestamp}_$randomPart';
  }
}

