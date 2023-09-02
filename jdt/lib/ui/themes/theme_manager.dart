import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/module_theme.dart';

/* ------------------------------ ModuleThemeManager ------------------------------ */
/// Manages the applications appearance and themes.
class ModuleThemeManager {
  /// The Global ThemeManager Instance
  static final ModuleThemeManager _instance = ModuleThemeManager._internal();
  static const String _themeDirectory = 'assets/themes';
  static ModuleTheme? _currentTheme;
  static final ModuleTheme _errorTheme = ModuleTheme(
    name: 'Error',
    id: "jdt_core_error_theme",
    icon: Icons.error_outline,
    brightness: Brightness.light,
  );

  /* -------------------------- factory ModuleThemeManager -------------------------- */
  /// This returns the global instance of the [ModuleThemeManager] and ensures that no additional
  /// [ModuleThemeManager] instances are ever constructed.
  factory ModuleThemeManager() {
    return _instance;
  }

  /* -------------------------------- _internal ------------------------------- */
  /// [ModuleThemeManager] constructor
  ModuleThemeManager._internal() {
    // initialization logic
  }

  /// Gets the protected directory from the constant field.
  String get themeDirectory => _themeDirectory;

  set theme(ModuleTheme theme) {
    _currentTheme = theme;
  }

  ModuleTheme get currentTheme => _currentTheme ?? _errorTheme;
}
