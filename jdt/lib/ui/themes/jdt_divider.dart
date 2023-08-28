import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class JdtDivider extends StatelessWidget {
  JdtDivider({
    super.key,
    this.abovePadding = 0.0,
    this.belowPadding = 0.0,
  });

  double abovePadding;
  double belowPadding;

  ModuleThemeManager _themeManager = ModuleThemeManager();

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
