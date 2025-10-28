import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'features/business_card/data/models/business_card_model.dart';
import 'features/business_card/presentation/screens/privacy_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for web and mobile
  await Hive.initFlutter();
  
  // Register Hive adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(BusinessCardModelAdapter());
  }

  runApp(
    const ProviderScope(
      child: CardBlinkApp(),
    ),
  );
}

class CardBlinkApp extends StatelessWidget {
  const CardBlinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const PrivacyScreen(),
    );
  }
}
