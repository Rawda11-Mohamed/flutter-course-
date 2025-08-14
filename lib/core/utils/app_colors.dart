import 'package:flutter/material.dart';

abstract class AppColors
{
  static const Color primary = Color(0xff149954);
  static const Color grey = Color(0xff6E6A7C);
  static const Color background = Color(0xffF3F5F4);
  static const Color greyBackground = Color(0xFFF3F5F4);
  static const Color green = Color(0xFF149954);
  static const Color black = Color(0xFF1D1C1B);
  static const Color lightGrey = Color(0xFF6E6A7C);
  static const Color taskCardLightGreen = Color(0xFFCEEBDC);
  static const Color taskCardPink = Color(0xFFFFE4F2);
  static const Color pink = Color(0xFFFF0084);
  static const Color blackText = Color(0xFF24252C);
  static const Color white = Colors.white;
  static const Color appBackgroundColor = Color(0xFFF3F5F4);
  static const Color primaryGreen = Color(0xFF149954);
  static const Color primaryTextColor = Color(0xFF24252C);
  static const Color placeholderColor = Color(0xFF6E6A7C);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFEEEEEE);

  // Backgrounds
  static const Color screenBackground = Color(0xFFE0E0E0); // Light gray background
  static const Color searchFieldFill = Color(0xFFF5F5F5); // Slightly darker than background

  // Task Card
  static const Color taskCardBg = Color(0xFFFFFFFF); // Pure white card background
  static const Color taskTitleText = Color(0xFF333333); // Dark gray text

  // Status Tags
  static const Color statusInProgress = Color(0xFF32CD32); // Lime green ("In Progress", "Done")
  static const Color statusMissed = Color(0xFFC70039); // Deep red ("Missed")
  static const Color statusText = Color(0xFFFFFFFF); // White text on tags

  // Filter Modal
  static const Color filterChipInactive = Color(0xFFD3D3D3); // Light gray for inactive filter chips
  static const Color filterButton = Color(0xFF32CD32); // Same green as status tags

  // Icons & Text
  static const Color iconAndText = Color(0xFF000000); // Black for icons and titles
  static const Color helperText = Color(0xFF888888); // Gray for helper text (e.g. timestamp)
}