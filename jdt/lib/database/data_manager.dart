import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jdt/utils/constants.dart';
import 'package:jdt/database/themebox.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/utils/extensions.dart';

/// flutter packages pub run build_runner build

/* ------------------------------- DataManager ------------------------------ */
/// The DataManager is responsible for all local database interactions using Hive.
class DataManager {
  static final DataManager _instance = DataManager._internal();
  static late Box _themeBox;

  /* -------------------------- factory DataManager -------------------------- */
  /// This returns the global instance of the [DataManager] and ensures that no additional
  /// [DataManager] instances are ever constructed.
  factory DataManager() {
    return _instance;
  }

  /* -------------------------------- _internal ------------------------------- */
  /// [DataManager] constructor
  DataManager._internal() {
    //todo
  }

  initialize() async {
    _themeBox = await Hive.openBox<ThemeBox>(themeBoxId);

    _themeBox.put(
      'jdt_core_light_theme',
      ThemeBox(
        id: 'jdt_core_light_theme',
        name: 'Light Theme',
        icon: Icons.light_mode_outlined.codePoint,
        brightness: Brightness.light.toString(),
        titleTextFontSize: 30.0,
        subtitleTextFontSize: 12.0,
        textFontSize: 14.0,
        buttonTextFontSize: 14.0,
        cardBorderRadius: 15.0,
        inputBorderRadius: 30.0,
        navbarBorderRadius: 15.0,
        buttonBorderRadius: 15.0,
        innerHorizontalPadding: 10.0,
        innerVerticalPadding: 10.0,
        outerHorizontalPadding: 20.0,
        outerVerticalPadding: 20.0,
        textFieldBackgroundColor: const Color(0xffe7e3e8).toStringARGB,
        cardBackgroundColor: const Color(0x77685C55).toStringARGB,
        overlayBackgroundColor: const Color(0xff685C55).toStringARGB,
        backgroundColor: const Color(0xffe7e3e8).toStringARGB,
        highlightColor: const Color(0x77b7cad4).toStringARGB,
        overlayForgroundColor: const Color(0xffe7e3e8).toStringARGB,
        iconColor: const Color(0xff685C55).toStringARGB,
        titleTextColor: const Color(0xff131014).toStringARGB,
        subtitleTextColor: const Color(0xff131014).toStringARGB,
        textColor: const Color(0xff131014).toStringARGB,
        buttonTextColor: const Color(0xffe7e3e8).toStringARGB,
        errorColor: const Color(0xff685C55).toStringARGB,
        accentColor: const Color(0xffb7cad4).toStringARGB,
      ),
    );
  }

  /* --------------------------- getThemeFromStorage -------------------------- */
  /// Gets the [ModuleTheme] from storage based on the provided [themeId]. If there is no
  /// such theme with the passed id, a placeholder error theme will be returned.
  ModuleTheme getThemeFromStorage(String themeId) {
    var retrievedTheme = _themeBox.get(themeId);

    if (retrievedTheme.runtimeType != ThemeBox) {
      return ModuleTheme(
        name: 'Error',
        id: "jdt_core_error_theme",
        icon: Icons.error_outline,
        brightness: Brightness.light,
      );
    }

    retrievedTheme = retrievedTheme as ThemeBox;

    return ModuleTheme(
      id: retrievedTheme.id,
      name: retrievedTheme.name,
      icon: IconData(retrievedTheme.icon, fontFamily: themeBoxFontFamily),
      brightness: (retrievedTheme.brightness.contains('light'))
          ? Brightness.light
          : Brightness.dark,
      accentColor: ColorStrings.fromStringARGB(retrievedTheme.accentColor),
      backgroundColor:
          ColorStrings.fromStringARGB(retrievedTheme.backgroundColor),
      buttonTextColor:
          ColorStrings.fromStringARGB(retrievedTheme.buttonTextColor),
      cardBackgroundColor:
          ColorStrings.fromStringARGB(retrievedTheme.cardBackgroundColor),
      errorColor: ColorStrings.fromStringARGB(retrievedTheme.errorColor),
      highlightColor:
          ColorStrings.fromStringARGB(retrievedTheme.highlightColor),
      iconColor: ColorStrings.fromStringARGB(retrievedTheme.iconColor),
      overlayBackgroundColor:
          ColorStrings.fromStringARGB(retrievedTheme.overlayBackgroundColor),
      overlayForgroundColor:
          ColorStrings.fromStringARGB(retrievedTheme.overlayForgroundColor),
      subtitleTextColor:
          ColorStrings.fromStringARGB(retrievedTheme.subtitleTextColor),
      textColor: ColorStrings.fromStringARGB(retrievedTheme.textColor),
      textFieldBackgroundColor:
          ColorStrings.fromStringARGB(retrievedTheme.backgroundColor),
      titleTextColor:
          ColorStrings.fromStringARGB(retrievedTheme.titleTextColor),
      subtitleTextFontSize: retrievedTheme.subtitleTextFontSize,
      textFontSize: retrievedTheme.textFontSize,
      titleTextFontSize: retrievedTheme.titleTextFontSize,
      navbarBorderRadius: retrievedTheme.navbarBorderRadius,
      inputBorderRadius: retrievedTheme.inputBorderRadius,
      cardBorderRadius: retrievedTheme.cardBorderRadius,
      buttonTextFontSize: retrievedTheme.buttonTextFontSize,
      buttonBorderRadius: retrievedTheme.buttonBorderRadius,
      innerHorizontalPadding: retrievedTheme.innerHorizontalPadding,
      innerVerticalPadding: retrievedTheme.innerVerticalPadding,
      outerHorizontalPadding: retrievedTheme.outerHorizontalPadding,
      outerVerticalPadding: retrievedTheme.outerVerticalPadding,
    );
  }
}
