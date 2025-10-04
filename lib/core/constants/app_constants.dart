class AppConstants {
  // App Info
  static const String appName = 'Task Iron';
  static const String appNameEn = 'Task Iron';
  static const String appVersion = '1.0.0';

  // Asset Paths
  static const String jsonAssetPath = '2-i.json';
  static const String iconsPath = 'assete/icons/';

  // Error Messages
  static const String defaultErrorMessage = 'حدث خطأ غير متوقع';
  static const String dataLoadErrorMessage = 'خطأ في تحميل البيانات';
  static const String noDataMessage = 'لا توجد بيانات';
  static const String retryMessage = 'إعادة المحاولة';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double iconSize = 32.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Logging
  static const bool enableLogging = true;
  static const String logTag = 'SteelApp';
}

class AppColors {
  // Primary colors - Black and Orange only as per reference images
  static const primary = 0xFF000000; // Black
  static const primaryLight = 0xFF424242;
  static const primaryDark = 0xFF000000;

  // Secondary colors
  static const secondary = 0xFF757575; // Grey
  static const secondaryLight = 0xFFBDBDBD;
  static const secondaryDark = 0xFF424242;

  // Accent colors - Orange for slider
  static const accent = 0xFFFF9800; // Orange
  static const accentLight = 0xFFFFB74D;
  static const accentDark = 0xFFF57C00;

  // Status colors
  static const error = 0xFFF44336;
  static const warning = 0xFFFF9800;
  static const success = 0xFF4CAF50;
  static const info = 0xFF000000;

  // UI colors
  static const background = 0xFFF5F5F5;
  static const surface = 0xFFFFFFFF;
  static const onSurface = 0xFF000000;
  static const onBackground = 0xFF000000;

  // Text colors
  static const textPrimary = 0xFF000000;
  static const textSecondary = 0xFF757575;
  static const textHint = 0xFFBDBDBD;

  // Border colors
  static const border = 0xFFE0E0E0;
  static const divider = 0xFFBDBDBD;
}

class AppStrings {
  // Arabic Strings
  static const String loadingAr = 'جاري التحميل...';
  static const String errorAr = 'خطأ';
  static const String retryAr = 'إعادة المحاولة';
  static const String detailsAr = 'التفاصيل';
  static const String closeAr = 'إغلاق';
  static const String okAr = 'موافق';

  // English Strings
  static const String loadingEn = 'Loading...';
  static const String errorEn = 'Error';
  static const String retryEn = 'Retry';
  static const String detailsEn = 'Details';
  static const String closeEn = 'Close';
  static const String okEn = 'OK';
}

class AppDimensions {
  // Screen breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Component sizes
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 60.0;
  static const double fabSize = 56.0;
  static const double cardElevation = 4.0;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
}
