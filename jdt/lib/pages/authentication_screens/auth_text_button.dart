import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class AuthTextButton extends StatelessWidget {
  AuthTextButton({
    super.key,
    required this.text,
    required this.linkText,
    required this.callback,
  });

  VoidCallback callback;
  String text;
  String linkText;

  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.titleSmall,
        children: <TextSpan>[
          TextSpan(
            text: linkText,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: _loadedTheme.accentColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                callback();
              },
          ),
        ],
      ),
    );
  }
}
