import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class AuthTitle extends StatelessWidget {
  AuthTitle({
    super.key,
    required this.title,
    this.suffix = '.',
  });
  String title;
  String suffix;
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: _loadedTheme.innerVerticalPadding * 0.1,
      ),
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.displayLarge,
          children: <TextSpan>[
            TextSpan(
                text: suffix,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: _loadedTheme.accentColor,
                      fontSize: _loadedTheme.titleTextFontSize + 4,
                    )),
          ],
        ),
      ),
    );
  }
}
