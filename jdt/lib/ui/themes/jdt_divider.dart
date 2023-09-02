// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

/* ------------------------------- JdtDivider ------------------------------- */
/// A custom divider used throughout the application. Has rounded borders!
class JdtDivider extends StatelessWidget {
  JdtDivider({
    super.key,
    this.abovePadding = 0.0,
    this.belowPadding = 0.0,
  });

  /// Padding above/below the divider
  double abovePadding;
  double belowPadding;

  final ModuleThemeManager _themeManager = ModuleThemeManager();

  /* ---------------------------------- build --------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: abovePadding,
        bottom: belowPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(
              _themeManager.currentTheme.cardBorderRadius),
        ),
        width: double.infinity,
        height: 3,
      ),
    );
  }
}
