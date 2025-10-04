import 'package:flutter/material.dart';
import 'screens/steel_viewer_screen.dart';
import 'core/constants/app_constants.dart';

void main() {
  runApp(const SteelSectionApp());
}

class SteelSectionApp extends StatelessWidget {
  const SteelSectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مقاطع الحديد',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(AppColors.primary),
          brightness: Brightness.light,
          surface: Color(AppColors.surface),
        ),
        fontFamily: 'Arial',
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(AppColors.textPrimary),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(AppColors.textSecondary),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(AppColors.primary),
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Color(AppColors.background),
      ),
      home: const SteelViewerScreen(),
    );
  }
}
