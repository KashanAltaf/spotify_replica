/// Application asset paths
/// Centralized asset path definitions for easy access and refactoring
class AppAssets {
  // Image paths
  static const String imagesPath = 'assets/images';
  static const String iconsPath = 'assets/icons';
  static const String fontsPath = 'assets/fonts';
  
  // Images
  static const String logo = '$imagesPath/logo.png';
  static const String logoDark = '$imagesPath/logo_dark.png';
  static const String placeholder = '$imagesPath/placeholder.png';
  static const String splash = '$imagesPath/splash.png';
  static const String onboarding1 = '$imagesPath/onboarding_1.png';
  static const String onboarding2 = '$imagesPath/onboarding_2.png';
  static const String onboarding3 = '$imagesPath/onboarding_3.png';
  
  // Icons
  static const String iconLogo = '$iconsPath/spotify_logo.png';
  static const String iconSearch = '$iconsPath/search.svg';
  static const String iconLibrary = '$iconsPath/library.svg';
  static const String iconProfile = '$iconsPath/profile.svg';
  static const String iconPlay = '$iconsPath/play.svg';
  static const String iconPause = '$iconsPath/pause.svg';
  static const String iconNext = '$iconsPath/next.svg';
  static const String iconPrevious = '$iconsPath/previous.svg';
  static const String iconLike = '$iconsPath/like.svg';
  static const String iconLiked = '$iconsPath/liked.svg';
  static const String iconShare = '$iconsPath/share.svg';
  static const String iconMore = '$iconsPath/more.svg';
  
  // Fonts
  static const String fontFamilyPrimary = 'Circular';
  static const String fontFamilySecondary = 'Gotham';
  
  // Private constructor to prevent instantiation
  AppAssets._();
}

/// Asset helper extensions
extension AssetHelper on String {
  /// Get image asset path
  String get image => this;
  
  /// Get icon asset path
  String get icon => this;
  
  /// Get font asset path
  String get font => this;
}

