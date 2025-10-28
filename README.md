# 📇 CardBlink

**Smart Business Card Scanner with OCR Technology**

[![Flutter](https://img.shields.io/badge/Flutter-3.5.0-02569B?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-blue)](https://flutter.dev)

CardBlink is a modern, cross-platform business card scanner application that uses OCR (Optical Character Recognition) to automatically extract contact information from business cards. Perfect for conferences, trade shows, and networking events.

[**English**](#english) | [**Türkçe**](#türkçe)

---

## English

### ✨ Features

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

### 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### 👨‍💻 Developer

Developed with ❤️ by [sevggii](https://github.com/sevggii)

### 🙏 Acknowledgments

- [Flutter](https://flutter.dev) - UI framework
- [Google ML Kit](https://developers.google.com/ml-kit) - Text recognition for mobile
- [Tesseract.js](https://tesseract.projectnaptha.com/) - OCR for web

---

## Türkçe

### ✨ Özellikler

- 📸 **Akıllı OCR Tarama** - İş kartı görüntülerinden otomatik metin tanıma
- 🔍 **Akıllı Ayrıştırma** - Ad, ünvan, şirket, e-posta, telefon, web sitesi ve adres çıkarma
- 🚫 **Tekrar Algılama** - Aynı kişiyi iki kez kaydetmenizi önler
- 💾 **Yerel Depolama** - Tüm veriler cihazınızda güvenle saklanır (Mobil için SQLite, Web için Hive)
- 📊 **Dışa Aktarma Seçenekleri** - Kişilerinizi CSV veya Excel olarak dışa aktarın
- 🔒 **Gizlilik Öncelikli** - OCR işleme tamamen cihazda gerçekleşir, sunuculara veri gönderilmez
- 🎨 **Material 3 Tasarım** - Modern, temiz ve sezgisel kullanıcı arayüzü
- 🌐 **Çapraz Platform** - iOS, Android ve Web'de sorunsuz çalışır

### 🛠️ Teknoloji Yığını

| Kategori | Teknoloji |
|----------|-----------|
| **Framework** | Flutter 3.5+ |
| **State Management** | Riverpod |
| **Mimari** | Clean Architecture (Domain/Data/Presentation) |
| **OCR (Mobil)** | Google ML Kit Text Recognition |
| **OCR (Web)** | Tesseract.js (JavaScript interop ile) |
| **Veritabanı (Mobil)** | SQLite (sqflite) |
| **Veritabanı (Web)** | Hive |
| **Dışa Aktarma** | Excel & CSV paketleri |
| **Görüntü İşleme** | Image Picker, Camera |

### 📋 Gereksinimler

- Flutter SDK 3.5.0 veya üzeri
- Dart 3.0 veya üzeri
- Mobil için iOS 12.0+ / Android 5.0+
- Web platformu için modern web tarayıcı

### 🚀 Kurulum & Başlangıç

1. **Depoyu klonlayın**
```bash
git clone https://github.com/sevggii/CardBlink.git
cd CardBlink
```

2. **Bağımlılıkları yükleyin**
```bash
flutter pub get
```

3. **Hive adapterlerini oluşturun**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. **Uygulamayı çalıştırın**

Web için:
```bash
flutter run -d chrome
```

iOS için:
```bash
flutter run -d ios
```

Android için:
```bash
flutter run -d android
```

### 📱 Kullanım

1. **İlk Başlatma** - Gizlilik bildirimini okuyun ve kabul edin
2. **Kart Tara** - Bir iş kartını yakalamak için kamera düğmesine dokunun
3. **İncele & Düzenle** - Çıkarılan bilgileri kontrol edin
4. **Kaydet** - Kart otomatik olarak yerel veritabanınıza kaydedilir
5. **Dışa Aktar** - Gerektiğinde tüm kişileri CSV veya Excel olarak dışa aktarın

### 🏗️ Proje Yapısı

```
lib/
├── core/
│   ├── constants/         # Uygulama sabitleri
│   ├── services/          # OCR servisi, metin ayrıştırıcı
│   ├── theme/             # Material 3 tema
│   └── utils/             # Yardımcı fonksiyonlar
├── features/
│   └── business_card/
│       ├── data/          # Veri katmanı
│       │   ├── datasources/   # Yerel depolama implementasyonları
│       │   ├── models/        # Veri modelleri
│       │   └── repositories/  # Repository implementasyonları
│       ├── domain/        # Domain katmanı
│       │   ├── entities/      # İş varlıkları
│       │   └── repositories/  # Repository arayüzleri
│       └── presentation/  # Sunum katmanı
│           ├── providers/     # Riverpod state management
│           ├── screens/       # UI ekranları
│           └── widgets/       # Yeniden kullanılabilir widget'lar
└── main.dart              # Uygulama giriş noktası
```

### 📸 Ekran Görüntüleri

*Ekran görüntüleri buraya eklenecek*

| Ana Ekran | Kart Tara | Kart Detayları |
|-----------|-----------|----------------|
| ![Ana Ekran](screenshots/home.png) | ![Tara](screenshots/scan.png) | ![Detay](screenshots/detail.png) |

### 🔐 Gizlilik & Güvenlik

- ✅ Tüm OCR işlemleri cihazınızda yerel olarak gerçekleşir
- ✅ Harici sunuculara veri gönderilmez
- ✅ Tüm kişi bilgileri yerel olarak saklanır
- ✅ Verileriniz üzerinde tam kontrole sahipsiniz

### 🤝 Katkıda Bulunma

Katkılar memnuniyetle karşılanır! Lütfen bir Pull Request göndermekten çekinmeyin.

1. Depoyu fork edin
2. Feature branch'inizi oluşturun (`git checkout -b feature/HarikaOzellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Harika özellik eklendi'`)
4. Branch'inize push edin (`git push origin feature/HarikaOzellik`)
5. Bir Pull Request açın

### 📄 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır - detaylar için [LICENSE](LICENSE) dosyasına bakın.

### 👨‍💻 Geliştirici

❤️ ile geliştirildi - [sevggii](https://github.com/sevggii)

### 🙏 Teşekkürler

- [Flutter](https://flutter.dev) - UI framework
- [Google ML Kit](https://developers.google.com/ml-kit) - Mobil için metin tanıma
- [Tesseract.js](https://tesseract.projectnaptha.com/) - Web için OCR

---

<p align="center">
  Made with ❤️ and Flutter
</p>
