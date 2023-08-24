import 'package:hive/hive.dart';

part 'themebox.g.dart';

@HiveType(typeId: 1)
class ThemeBox {
  ThemeBox({
    /// General Theme Information
    required this.id,
    required this.name,
    required this.icon,
    required this.brightness,

    /// Font Sizes
    required this.titleTextFontSize,
    required this.subtitleTextFontSize,
    required this.textFontSize,
    required this.buttonTextFontSize,

    /// Border Radius
    required this.cardBorderRadius,
    required this.inputBorderRadius,
    required this.navbarBorderRadius,
    required this.buttonBorderRadius,

    /// Background colors
    required this.textFieldBackgroundColor,
    required this.cardBackgroundColor,
    required this.overlayBackgroundColor,
    required this.backgroundColor,

    /// Forground colors
    required this.highlightColor,
    required this.overlayForgroundColor,
    required this.iconColor,
    required this.titleTextColor,
    required this.subtitleTextColor,
    required this.textColor,
    required this.buttonTextColor,
    required this.errorColor,
    required this.accentColor,

    /// Padding
    required this.innerHorizontalPadding,
    required this.innerVerticalPadding,
    required this.outerHorizontalPadding,
    required this.outerVerticalPadding,
  });

  /* ------------------------ General Theme Information ----------------------- */
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int icon;

  @HiveField(3)
  String brightness;

  /* ------------------------------- Font Sizes ------------------------------- */
  @HiveField(4)
  double titleTextFontSize;

  @HiveField(5)
  double subtitleTextFontSize;

  @HiveField(6)
  double textFontSize;

  @HiveField(7)
  double buttonTextFontSize;

  /* ------------------------------ Border Radius ----------------------------- */
  @HiveField(8)
  double cardBorderRadius;

  @HiveField(9)
  double inputBorderRadius;

  @HiveField(10)
  double navbarBorderRadius;

  @HiveField(11)
  double buttonBorderRadius;

  /* ---------------------------- Background Colors --------------------------- */
  @HiveField(12)
  String textFieldBackgroundColor;

  @HiveField(13)
  String cardBackgroundColor;

  @HiveField(14)
  String overlayBackgroundColor;

  @HiveField(15)
  String backgroundColor;

  /* ---------------------------- Forground Colors ---------------------------- */

  @HiveField(16)
  String highlightColor;

  @HiveField(17)
  String overlayForgroundColor;

  @HiveField(18)
  String iconColor;

  @HiveField(19)
  String titleTextColor;

  @HiveField(20)
  String subtitleTextColor;

  @HiveField(21)
  String textColor;

  @HiveField(22)
  String buttonTextColor;

  @HiveField(23)
  String errorColor;

  @HiveField(24)
  String accentColor;

  /* --------------------------------- Padding -------------------------------- */

  @HiveField(25)
  double innerVerticalPadding;

  @HiveField(26)
  double innerHorizontalPadding;

  @HiveField(27)
  double outerVerticalPadding;

  @HiveField(28)
  double outerHorizontalPadding;
}
