import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class AuthButton extends StatefulWidget {
  AuthButton({
    super.key,
    required this.width,
    required this.height,
    required this.isLoading,
    required this.callback,
    this.text = "Sign in",
    this.duration = const Duration(milliseconds: 450),
  });

  String text;
  double width;
  double height;
  Duration duration;
  bool isLoading;
  VoidCallback callback;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;

  double _sizeModifier = 1;

  tapEngine() async {
    widget.callback();

    setState(() {
      _sizeModifier = 0.5;
    });
  }

  resize() {
    setState(() {
      _sizeModifier = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      resize();
    }

    return AbsorbPointer(
      absorbing: widget.isLoading,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Center(
          child: AnimatedContainer(
            duration: widget.duration,
            curve: Curves.easeInOutCubicEmphasized,
            width: widget.width * _sizeModifier,
            height: widget.height * _sizeModifier,
            child: ElevatedButton(
              onPressed: () {
                tapEngine();
              },
              child: Stack(children: [
                if (!widget.isLoading)
                  Text(
                    widget.text,
                  ),
                if (widget.isLoading)
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(_loadedTheme.cardBorderRadius)),
                    child: LinearProgressIndicator(
                      backgroundColor: _loadedTheme.accentColor,
                      color: _loadedTheme.buttonTextColor.withOpacity(0.2),
                      minHeight: widget.height,
                    ),
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
