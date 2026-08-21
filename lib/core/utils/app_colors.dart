import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background Colors
  static const Color blue50 = Color(0xFFE3F2FD);
  static const Color onboardingColor = Color(0xFFF5F5F7);
  static const Color loadingColor = Color(0xFF60A79F);
  static const Color loadingBacColor = Color(0x7B65711A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color homeLinear = Color(0x7B65711A);

  // Primary Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFF4DD0E1);
  static const Color lightBlueBg = Color(0xFFE3F2FD);
  static const Color lightOrangeBg = Color(0xFFFFF3E0);
  static const Color lightPinkBg = Color(0xFFFFEBEE);
  static const Color appBarColor = Color(0xFF30B3FB);
  static const Color selectedTabColor = Color(0xFF0033CF);

  // Icon Colors
  static const Color coralRed = Color(0xFFE53935);
  static const Color orange = Color(0xFFFF9800);

  // Alert Colors
  static const Color transparent = Color(0x00000000);
  static const Color red = Colors.red;

  // Utility colors
  static Color grey400 = Colors.grey[400]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey700 = Colors.grey[700]!;

  //green
  static const Color blackGreen = Color(0xFF004D3C);
  static const Color green = Color(0xFF007A5E);

  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF14161A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);

  static const Color border = Color(0xFFE5E7EB);
  static const Color fieldFill = Color(0xFFF1F2F4);

  static const Color blue = Color(0xFF2E86F0);
  static const Color blueLight = Color(0xFFEAF3FE);

  static const Color redLight = Color(0xFFFDECEC);
  static const Color pink = Color(0xFFEF9A9A);

  static const Color greenLight = Color(0xFFE9F8EF);

  static const Color orangeLight = Color(0xFFFEF3E2);

  static const Color blueBadgeBg = Color(0xFFDCEAFE);

  static const Color chipBlack = Color(0xFF14161A);

  static const double radiusSm = 8;
  static const double radiusMd = 10;
  static const double radiusLg = 14;
}

class AppText {
  AppText._();

  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );

  static const TextStyle body = TextStyle(
    fontSize: 13,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMuted = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );



}