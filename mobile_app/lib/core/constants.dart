import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Website Exact Dual-Tone Palette: Premium Steel Blue & Warm Champagne
  static const Color background = Color(0xFFF8FAFC);      // Light cool slate wash
  static const Color surface = Color(0xFFFFFFFF);         // Clean crisp white
  static const Color card = Color(0xFFFFFFFF);            // Elevated white card
  
  // Primary Steel Blue (Matching website --primary-600)
  static const Color primary = Color(0xFF3B6582);         // Primary Calm Steel Blue
  static const Color primaryLight = Color(0xFFE4EDF2);    // Light steel blue tint
  static const Color primaryDark = Color(0xFF2C4C64);     // Deep Slate Blue Accent

  // Dual-Tone Warm Champagne / Gold Accent (Matching website --warning-500)
  static const Color champagne = Color(0xFFCDA174);       // Soft Sand Gold
  static const Color champagneLight = Color(0xFFFBF9F5);  // Warm beige wash
  static const Color champagneBorder = Color(0xFFEBDCC9); // Soft sand border

  // Semantic Colors (Matching website)
  static const Color success = Color(0xFF3B9B58);         // Calm Emerald Green
  static const Color successLight = Color(0xFFEAF5EC);    // Soft Mint wash
  static const Color danger = Color(0xFFDC5252);          // Premium Rose Red
  static const Color dangerLight = Color(0xFFFDF2F2);     // Soft Rose wash

  // Neutral Slate Text & Borders
  static const Color textPrimary = Color(0xFF0F172A);     // Slate 900
  static const Color textSecondary = Color(0xFF475569);   // Slate 600
  static const Color textMuted = Color(0xFF94A3B8);       // Slate 400
  static const Color border = Color(0xFFE2E8F0);          // Slate 200 border
  static const Color borderLight = Color(0xFFF1F5F9);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.champagne,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.light().textTheme,
      ).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      cardTheme: CardTheme(
        color: AppColors.card,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 1,
        shadowColor: Color(0x0A000000),
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
