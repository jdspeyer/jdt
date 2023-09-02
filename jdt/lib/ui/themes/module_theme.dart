// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ModuleTheme {
  ModuleTheme({
    /// General Theme Information
    required this.name,
    required this.id,
    required this.icon,
    required this.brightness,
    this.titleFontFamily = "Poppins",
    this.bodyFontFamily = "Poppins",

    /// Font Sizes
    this.titleTextFontSize = 20.0,
    this.subtitleTextFontSize = 12.0,
    this.textFontSize = 14.0,
    this.buttonTextFontSize = 14.0,

    /// Border Radius
    this.cardBorderRadius = 0.0,
    this.inputBorderRadius = 0.0,
    this.navbarBorderRadius = 0.0,
    this.buttonBorderRadius = 0.0,

    /// Padding
    this.innerHorizontalPadding = 0.0,
    this.innerVerticalPadding = 0.0,
    this.outerHorizontalPadding = 0.0,
    this.outerVerticalPadding = 0.0,

    /// Background Colors
    this.textFieldBackgroundColor = Colors.grey,
    this.cardBackgroundColor = Colors.grey,
    this.overlayBackgroundColor = Colors.white,
    this.backgroundColor = Colors.white,

    /// Forground Colors (Texts, icons, etc)
    this.highlightColor = Colors.lightBlue,
    this.overlayForgroundColor = Colors.black,
    this.iconColor = Colors.red,
    this.titleTextColor = Colors.black,
    this.subtitleTextColor = Colors.grey,
    this.textColor = Colors.black,
    this.buttonTextColor = Colors.white,
    this.errorColor = Colors.red,
    this.accentColor = Colors.blue,
  });
  String id;
  String name;
  IconData icon;
  Brightness brightness;
  String titleFontFamily;
  String bodyFontFamily;

  /* ------------------------------ Border Radius ----------------------------- */
  /// The border radius used to round the edges of cards.
  double cardBorderRadius;

  /// The border radius used for input fields.
  double inputBorderRadius;

  /// The border radius used for the navbar.
  double navbarBorderRadius;

  /// The border radius used for buttons
  double buttonBorderRadius;

  /* --------------------------------- Colors --------------------------------- */
  /// The background color of pages.
  Color backgroundColor;

  /// The color of cards throughout the application.
  Color cardBackgroundColor;

  /// The background color of text fields throughout the application.
  Color textFieldBackgroundColor;

  /// The color of text elements within the application (general text elements).
  Color textColor;

  /// The color of titles (text elements -- this should contrast well with the background color && card color).
  Color titleTextColor;

  /// The color of subtitle elements throughout the application.
  Color subtitleTextColor;

  /// The color of buttons throughout the application.
  Color buttonTextColor;

  /// The color which occurs on hover and selection of elements.
  Color overlayBackgroundColor;

  /// The color which occurs on hover and selection of elements.
  Color overlayForgroundColor;

  /// The color of icons throughout the application.
  Color iconColor;

  /// The color used to highlight text elements and general selection.
  Color highlightColor;

  /// The color used to indicate when an error has occured somewhere within the application.
  Color errorColor;

  /// The color used for accents and general pizaz!
  Color accentColor;

  /* ------------------------------- Font Sizing ------------------------------ */

  /// The font size of title text elements.
  double titleTextFontSize;

  /// The font size of subtitle.
  double subtitleTextFontSize;

  /// The font size of text elements.
  double textFontSize;

  /// The font size of button text elements.
  double buttonTextFontSize;

  /* --------------------------------- Padding -------------------------------- */
  /// NOTE: Some elements will use this in a calculation for their padding. Think of
  /// these as the starting place for padding which is used bu the whole application.

  /// The inner vertical padding used by each element (The space between an elements content and its container).
  double innerVerticalPadding;

  /// The inner horzontal padding used by each element (The space between an elements content and its container).
  double innerHorizontalPadding;

  /// The outer vertical padding used by each element (The space between elements).
  double outerVerticalPadding;

  /// The outer horizontal padding used by each element (The space between elements).
  double outerHorizontalPadding;

  ThemeData themeData() {
    return ThemeData(
      /// Font Family
      fontFamily: bodyFontFamily,

      /// Background Color
      backgroundColor: backgroundColor,

      /// Color used for cards and containers
      cardColor: cardBackgroundColor,

      primaryColor: accentColor,

      errorColor: accentColor,

      dividerColor: backgroundColor,

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentColor,
        selectionColor: accentColor.withOpacity(0.2),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: iconColor,
      ),

      /* ------------------------------- Text Styles ------------------------------ */
      textTheme: TextTheme(
        /// Title Styling (LRG)
        displayLarge: TextStyle(
          color: titleTextColor,
          fontSize: titleTextFontSize,
          fontWeight: FontWeight.w700,
          fontFamily: titleFontFamily,
        ),

        /// Title Styling (SUB)
        /// This is the same font size as the basic title but
        /// utilizes the text color instead.
        displayMedium: TextStyle(
          color: textColor,
          fontSize: titleTextFontSize * 0.75,
          fontWeight: FontWeight.w400,
          fontFamily: titleFontFamily,
        ),

        /// Title Styling (SML)
        /// Smaller version of the title used for emphasis
        displaySmall: TextStyle(
          color: titleTextColor,
          fontSize: textFontSize,
          fontFamily: titleFontFamily,
        ),

        /// Body Styling (LRG)
        /// Slightly larger version of the body text.
        bodyLarge: TextStyle(
          color: textColor,
          fontSize: textFontSize * 1.5,
        ),

        /// Body Styling (NORM)
        bodyMedium: TextStyle(
          color: textColor,
          fontSize: textFontSize,
        ),

        /// Body Styling (SML)
        /// Smaller version of the text style with the same coloring.
        bodySmall: TextStyle(
          color: textColor,
          fontSize: subtitleTextFontSize,
        ),

        /// For buttons and related
        labelLarge: TextStyle(
          color: buttonTextColor,
          fontSize: buttonTextFontSize,
        ),

        /// Subtitle large
        titleLarge: TextStyle(
          color: subtitleTextColor,
          fontSize: textFontSize,
        ),

        /// Subtitle regular
        titleMedium: TextStyle(
          color: subtitleTextColor.withOpacity(0.9),
          fontWeight: FontWeight.w500,
          fontSize: textFontSize,
        ),

        /// Subtitle small
        titleSmall: TextStyle(
          color: subtitleTextColor.withOpacity(0.85),
          fontSize: subtitleTextFontSize,
          fontWeight: FontWeight.w400,
        ),
      ),

      /* -------------------------------- Tool Tips ------------------------------- */
      tooltipTheme: TooltipThemeData(
        triggerMode: TooltipTriggerMode.longPress,
        padding: EdgeInsets.symmetric(
          horizontal: innerHorizontalPadding * 0.75,
          vertical: innerVerticalPadding * 0.75,
        ),
        textStyle: TextStyle(
          color: textColor,
          fontSize: subtitleTextFontSize,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(cardBorderRadius),
        ),
      ),

      /* ---------------------------------- Icons --------------------------------- */
      iconTheme: IconThemeData(
        color: iconColor,
      ),

      /* -------------------------------- Dividers -------------------------------- */
      dividerTheme: DividerThemeData(
        color: backgroundColor,
        thickness: 2,
      ),

      inputDecorationTheme: InputDecorationTheme(
        /// Generic
        border: OutlineInputBorder(
          borderSide: BorderSide(color: textColor.withOpacity(0.3)),
          borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius)),
        ),

        /// Enabled
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textColor.withOpacity(0.3)),
          borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius)),
        ),

        /// Disabled
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textColor.withOpacity(0.3)),
          borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius)),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textColor),
          borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius)),
        ),

        /// Error Border
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentColor),
          borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius)),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentColor),
          borderRadius: BorderRadius.all(
            Radius.circular(cardBorderRadius),
          ),
        ),

        iconColor: textColor,
        hintStyle: TextStyle(
          color: textColor.withOpacity(0.3),
          fontSize: textFontSize,
        ),
        helperStyle: TextStyle(
          color: textColor.withOpacity(0.3),
          fontSize: textFontSize,
        ),

        errorStyle: TextStyle(
          color: accentColor,
          fontSize: subtitleTextFontSize,
          height: 0.3,
        ),
        fillColor: textFieldBackgroundColor,
        contentPadding: EdgeInsets.all(innerHorizontalPadding),
        constraints: BoxConstraints(
          minHeight: 50,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: accentColor.withOpacity(0.3),
          disabledForegroundColor: buttonTextColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(buttonBorderRadius)),
          ),
          backgroundColor: accentColor,
          foregroundColor: buttonTextColor,
          padding: EdgeInsets.symmetric(
              vertical: innerVerticalPadding,
              horizontal: innerHorizontalPadding),
        ),
      ),
    );
  }
}
