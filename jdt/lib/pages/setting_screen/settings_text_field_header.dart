import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class SettingsTextFieldHeader extends StatelessWidget {
  SettingsTextFieldHeader({
    super.key,
    this.title = "Title",
    this.subtitle = "subtitle",
  });

  String title;
  String subtitle;

  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: _loadedTheme.innerVerticalPadding * 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .color!
                      .withOpacity(0.4),
                ),
          ),
        ],
      ),
    );
  }
}
