# 📇 CardBlink

**Smart Business Card Scanner with OCR Technology**

[![Flutter](https://img.shields.io/badge/Flutter-3.5.0-02569B?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-blue)](https://flutter.dev)

CardBlink is a modern, cross-platform business card scanner application that uses OCR (Optical Character Recognition) to automatically extract contact information from business cards. Perfect for conferences, trade shows, and networking events.

## ✨ Features

- 📸 **Smart OCR Scanning** - Automatic text recognition from business card images
- 🔍 **Intelligent Parsing** - Extracts name, title, company, email, phone, website, and address
- 🚫 **Duplicate Detection** - Prevents saving the same contact twice
- 💾 **Local Storage** - All data stored securely on your device (SQLite for mobile, Hive for web)
- 📊 **Export Options** - Export your contacts as CSV or Excel files
- 🔒 **Privacy First** - OCR processing happens entirely on-device, no data sent to servers
- 🎨 **Material 3 Design** - Modern, clean, and intuitive user interface
- 🌐 **Cross-Platform** - Works seamlessly on iOS, Android, and Web

### 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter 3.5+ |
| **State Management** | Riverpod |
| **Architecture** | Clean Architecture (Domain/Data/Presentation) |
| **OCR (Mobile)** | Google ML Kit Text Recognition |
| **OCR (Web)** | Tesseract.js (via JavaScript interop) |
| **Database (Mobile)** | SQLite (sqflite) |
| **Database (Web)** | Hive |
| **Export** | Excel & CSV packages |
| **Image Handling** | Image Picker, Camera |

### 📋 Prerequisites

- Flutter SDK 3.5.0 or higher
- Dart 3.0 or higher
- iOS 12.0+ / Android 5.0+ for mobile
- Modern web browser for web platform

### 🚀 Installation & Setup

1. **Clone the repository**
```bash
git clone https://github.com/sevggii/CardBlink.git
cd CardBlink
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate Hive adapters**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**

For web:
```bash
flutter run -d chrome
```

For iOS:
```bash
flutter run -d ios
```

For Android:
```bash
flutter run -d android
```

### 📱 Usage

1. **First Launch** - Read and accept the privacy notice
2. **Scan a Card** - Tap the camera button to capture a business card
3. **Review & Edit** - Check the extracted information
4. **Save** - The card is automatically saved to your local database
5. **Export** - Export all contacts as CSV or Excel when needed

### 🏗️ Project Structure

```
lib/
├── core/
│   ├── constants/         # App constants
│   ├── services/          # OCR service, text parser
│   ├── theme/             # Material 3 theme
│   └── utils/             # Utility functions
├── features/
│   └── business_card/
│       ├── data/          # Data layer
│       │   ├── datasources/   # Local storage implementations
│       │   ├── models/        # Data models
│       │   └── repositories/  # Repository implementations
│       ├── domain/        # Domain layer
│       │   ├── entities/      # Business entities
│       │   └── repositories/  # Repository interfaces
│       └── presentation/  # Presentation layer
│           ├── providers/     # Riverpod state management
│           ├── screens/       # UI screens
│           └── widgets/       # Reusable widgets
└── main.dart              # App entry point
```

### 📸 Screenshots

*Screenshots will be added here*

| Home Screen | Scan Card | Card Details |
|-------------|-----------|--------------|
| ![Home](screenshots/home.png) | ![Scan](screenshots/scan.png) | ![Detail](screenshots/detail.png) |

### 🔐 Privacy & Security

- ✅ All OCR processing happens locally on your device
- ✅ No data is sent to external servers
- ✅ All contact information is stored locally
- ✅ You have full control over your data

### 🙏 Acknowledgments

- [Flutter](https://flutter.dev) - UI framework
- [Google ML Kit](https://developers.google.com/ml-kit) - Text recognition for mobile
- [Tesseract.js](https://tesseract.projectnaptha.com/) - OCR for web
