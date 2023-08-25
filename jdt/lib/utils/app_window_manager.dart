import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

/* ------------------------------ WindowManager ------------------------------ */
/// Manages the applications appearance and themes.
class AppWindowManager {
  /// The Global ThemeManager Instance
  static final AppWindowManager _instance = AppWindowManager._internal();
  static const Size _windowSize = Size(924, 550);

  /* -------------------------- factory AppWindowManager -------------------------- */
  /// This returns the global instance of the [AppWindowManager] and ensures that no additional
  /// [AppWindowManager] instances are ever constructed.
  factory AppWindowManager() {
    return _instance;
  }

  /* -------------------------------- _internal ------------------------------- */
  /// [AppWindowManager] constructor
  AppWindowManager._internal() {
    // initialization logic
  }

  /* ---------------------------------- setup --------------------------------- */
  /// Sets up the window for display to the user
  setup() async {
    await _initializeWindow();
    await _setWindowSize();
    await _styleWindow();
  }

  /* ---------------------------- _initializeWindow ---------------------------- */
  /// Initializes the window and ensures that methods called after this point are valid.
  _initializeWindow() async {
    await windowManager.ensureInitialized();
    await windowManager.setResizable(false);
  }

  /* ------------------------------ _setWindowSize ----------------------------- */
  /// Sets the window size for the application
  _setWindowSize() async {
    await windowManager.setMinimumSize(_windowSize);
    await windowManager.setMaximumSize(_windowSize);
    await windowManager.setSize(_windowSize);
  }

  /* ------------------------------- _styleWindow ------------------------------ */
  /// Styles the window so that it looks the way we intend it to before displaying
  /// to the user.
  _styleWindow() async {
    WindowOptions windowOptions = const WindowOptions(
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  /// Gets the window size
  Size get windowSize => _windowSize;
}
