import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryPurple = Color(0xFF5117AC);
  static const Color searchBorderColor = Color(0xFFE2EDF2);
  static const Color appBarBackground = Color(0XFFFFFFFF);
  static const Color textPrimary = Color(0xFF153E73);
  static const Color textSecondary = Color(0xFFCFCFCF);
  static const Color selectedIcon = Color(0xFF20D0C4);

  static const List<Color> categoryColors = [
    Color(0xFFD0E6A5),
    Color(0xFF86E3CE),
    Color(0xFFFFDD95),
    Color(0xFFFFACAC),
    Color(0xFFCCAAD9),
  ];

  static Color getCategoryColor(int index) {
    return categoryColors[index % categoryColors.length];
  }
}
