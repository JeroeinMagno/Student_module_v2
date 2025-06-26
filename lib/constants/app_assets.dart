/// Asset path constants for images, icons, and other assets
class AppAssets {
  AppAssets._();

  // Base paths
  static const String _imagesPath = 'assets/images/';
  static const String _iconsPath = 'assets/icons/';

  // Icons
  static const String bsuLogo = '${_iconsPath}bsulogo.svg';

  // Images (placeholder paths - add actual image assets here)
  static const String placeholder = '${_imagesPath}placeholder.png';
  static const String avatar = '${_imagesPath}avatar.png';
  static const String emptyState = '${_imagesPath}empty_state.png';

  // Lottie animations (if any)
  static const String _animationsPath = 'assets/animations/';
  static const String loadingAnimation = '${_animationsPath}loading.json';
  static const String successAnimation = '${_animationsPath}success.json';
  static const String errorAnimation = '${_animationsPath}error.json';
}
