import 'package:flutter/material.dart';

/// Application color palette
/// Centralized color definitions for consistent theming
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1ED760); // Spotify green
  static const Color colorWhite = Colors.white; // Spotify white
  static const Color colorBlack = Color(0xFF121212); // Spotify black
  static const Color textColor = Color(0xFFB8B8B8); // Spotify text color
  static const Color iconColor = Color(0xFFB3B3B3); // Spotify icon color
  static const Color labelColor = Color(0xFFB3B3B3); // Spotify label color
  static const Color grayButtonColor = Color(0xFF2A2A2A); // Spotify gray button color
  static const Color greenButtonColor = Color(0xFF14833B); // Spotify green button color
  static const Color grayBgPrimary = Color(0xFF282828); // Spotify gray background primary color
  static const Color grayBgSecondary = Color(0xFF444444); // Spotify gray background secondary color
  static const Color divider = Color(0xFF1B1B1B); // Spotify divider color
  static const Color trackLine = Color(0xFF2A2A2A); // Spotify track line color
  static const Color buttonStroke = Color(0xFF7F7F7F); // Spotify button stroke color



  // Private constructor to prevent instantiation
  AppColors._();
}

/// Color extensions for easy access
extension AppColorScheme on ColorScheme {
  Color get spotifyGreen => AppColors.primary;
}

