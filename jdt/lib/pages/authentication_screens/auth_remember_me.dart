import 'package:flutter/material.dart';
import 'package:jdt/ui/icons/text_field_icon.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class AuthRememberMe extends StatefulWidget {
  AuthRememberMe({
    super.key,
    required this.remember,
    required this.rememberMeCallback,
    required this.forgotPasswordCallback,
  });
  VoidCallback rememberMeCallback;
  VoidCallback forgotPasswordCallback;
  bool remember;
  @override
  State<AuthRememberMe> createState() => _AuthRememberMeState();
}

class _AuthRememberMeState extends State<AuthRememberMe> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.rememberMeCallback,
            child: Row(
              children: [
                AbsorbPointer(
                  absorbing: true,
                  child: TextFieldIcon(
                    width: 15,
                    height: 15,
                    asset:
                        'assets/images/lottie/auth-checkmark-icon.rough.json',
                    canTap: true,
                    introStartKeyFrame: 0.5,
                    introEndKeyFrame: 0.6,
                    hoverStartKeyFrame: 0.6,
                    hoverEndKeyFrame: 0.8,
                    isSelected: widget.remember,
                    tapCallback: () {},
                  ),
                ),
                Text(
                  ' Remember me',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.forgotPasswordCallback,
            child: Text(
              "Forgot password?",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: _loadedTheme.accentColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
