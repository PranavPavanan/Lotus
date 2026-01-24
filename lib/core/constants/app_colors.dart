import 'package:flutter/material.dart';

/// Core color palette for The Sanctuary app
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryBeige = Color(0xFFFFF3E0); // Orange[50] equivalent
  static const Color accentWarm = Color(0xFFFFCC80);
  static const Color accentCozy = Color(0xFFBCAAA4);

  // Functional Colors
  static const Color success = Color(0xFF81C784);
  static const Color warning = Color(0xFFFFB74D);
  static const Color error = Color(0xFFE57373);

  // Text Colors
  static const Color textPrimary = Color(0xFF3E2723);
  static const Color textSecondary = Color(0xFF6D4C41);
  static const Color textHint = Color(0xFF8D6E63);

  // UI Elements
  static const Color cardBackground = Colors.white;
  static const Color modalOverlay = Color(0x80000000);
  static const Color divider = Color(0xFFD7CCC8);

  // Weather Ambience Colors (for Focus Mode)
  static const Color weatherRainy = Color(0xFF607D8B);
  static const Color weatherWinter = Color(0xFFB0BEC5);
  static const Color weatherSummer = Color(0xFFFFE082);
  static const Color weatherSpring = Color(0xFF81C784);

  // Coin/Reward Gold
  static const Color coinGold = Color(0xFFFFD700);
}
