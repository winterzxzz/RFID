import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  ///Background
  ///sta
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = primary;
  static const Color backgroundLightSub = Color(0xFFF0EEEF);
  static const Color backgroundDarkSub = secondary;
  static const Color backgroundMessage = Color(0xFFF5FBF7);
  static Color backgroundBlur = const Color(0xFF081C2C).withOpacity(0.24);
  static Color backgroundOverlay = backgroundDark.withOpacity(0.55);

  static const Color backgroundBottomTab = Color(0xFFff6b27);

  /// Appbar
  static const Color appBarLight = Colors.white;
  static const Color appBarDark = Color(0xFF3E4450);

  /// Add Button
  static const Color addButton = Color(0xFF465995);
  static const Color addButtonLight = Color(0xFF19B4FF);

  ///Common
  static const Color primary = Color(0xFF313443);
  static const Color secondary = Color(0xFF3E4450);
  static const Color error = Color(0xFFEB5757);
  static const Color success = Colors.green;

  ///Background
  static const Color background = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;

  ///Gray
  static const Color gray1 = Color(0xFFC9C8C8);
  static const Color gray2 = Color(0xFFF9F9F9);
  static const Color gray3 = Color(0xFF4A4A4A);

  ///Shadow
  static const Color shadow = Color.fromRGBO(0, 0, 0, 0.05);

  ///Border
  static const Color border = Color(0xFF606060);
  static const Color inputBorder = Color(0xFFEAEEF2);
  static const Color inputDisabled = Color(0xFFF1F1F1);
  static const Color focusBorder = primary;

  ///Divider
  static const Color divider = Color(0xFFD8D8D8);

  ///Text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF000000);
  static const Color textBlue = Color(0xFF1E8AE7);
  static const Color textGray = Color(0xFF6E8597);
  static const Color textTitle = Color(0xFF112519);
  static const Color textConversationName = Color(0xFF081C2C);

  ///TextField
  static const Color textFieldEnabledBorder = Color(0xFF919191);
  static const Color textFieldFocusedBorder = Color(0xFF1E8AE7);
  static const Color textFieldDisabledBorder = Color(0xFF919191);
  static const Color textFieldCursor = Color(0xFF919191);
  static const Color textFieldErrorBorder = Color(0xFFFB7181);

  ///Button
  static const Color buttonBGWhite = Color(0xFFcdd0d5);
  static const Color buttonBGPrimary = primary;
  static const Color buttonBGBlack = Color(0xFF4A4A4A);
  static const Color buttonBGDisabled = Colors.white;
  static const Color buttonBorder = Color(0xFFC9C8C8);
  static Color buttonSentRequest = primary.withOpacity(0.7);

  /// Tabs
  static const Color imageBG = Color(0xFF919191);

  ///BottomNavigationBar
  static const Color bottomNavigationBar = Colors.white;
  static const Color bottomNavigationActive = primary;
  static const Color bottomNavigationInactive = Color(0xFF6E8597);

  ///Shadow
  static const Color boxShadowColor = Color(0x3D40BFFF);

  /// Form
  static const Color label = Color(0xFF1F3C51);
  static const Color authText = Color(0xFF6E8597);
  static const Color clickableText = primary;
  static const Color text = Color(0xFF081C2C);
  static const Color hint = Color(0xFFB2B9BF);
  static const Color icon = Color(0xFF6E8597);
  static const Color activeButton = primary;
  static const Color inactiveButton = Colors.white;
  static const Color activeButtonText = Colors.white;
  static const Color inactiveButtonText = Colors.grey;
  static const Color loginInputBackground = Color(0xFFECF5FF);
  static const Color avatarBackground = Color(0xFFB3C2CE);
  static const Color actionMenuText = Color(0xFF6E8597);
  static const Color popupMenuText = Color(0xFF1F3C51);

  /// Icon
  static const Color iconError = Color(0xFFDD524C);
  static const ColorFilter primaryFilter =
      ColorFilter.mode(primary, BlendMode.srcIn);
}
