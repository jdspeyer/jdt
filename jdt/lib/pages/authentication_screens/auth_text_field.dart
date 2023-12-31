// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdt/ui/icons/text_field_icon.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField({
    super.key,
    this.hint = "Hint",
    this.initialValue = "",
    this.errorText = "",
    this.iconAsset = 'assets/images/lottie/auth-hide-icon.rough.json',
    this.iconAssetKeyframes = const [0.8, 1, 0.8, 1],
    this.isPasswordField = false,
    this.unblurIconAsset = 'assets/images/lottie/auth-hide-icon.rough.json',
    this.unblurIconAssetKeyframes = const [0.8, 1, 0.8, 1],
    required this.onEditCallback,
    required this.validationCallback,
    required this.textController,
  });

  String iconAsset;
  List<double> iconAssetKeyframes;
  String unblurIconAsset;
  List<double> unblurIconAssetKeyframes;
  String hint;
  String initialValue;
  String errorText;
  bool isPasswordField;
  TextEditingController textController;

  Function(
    String val,
  ) onEditCallback;

  bool Function(
    String val,
  ) validationCallback;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  /// Decoration used for when [showIcon] is true.

  late final FocusNode _node = FocusNode();
  bool _isSelected = false;
  bool _needsReset = false;
  late bool _shouldBlur = widget.isPasswordField;

  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  late bool _isValid = true;

  _onEdit(String val) {
    widget.onEditCallback(widget.textController.text);
    setState(() {});
  }

  @override
  void initState() {
    _node.addListener(() {
      _needsReset = true;
      setState(() {});
      if (_node.hasFocus) {
        _isSelected = true;
        setState(() {});
      } else {
        _isSelected = false;
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _node.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: TextFormField(
              obscureText: _shouldBlur,
              focusNode: _node,
              cursorColor: _loadedTheme.accentColor,
              decoration: InputDecoration(
                counterText: "",
                prefixIcon: TextFieldIcon(
                  asset: widget.iconAsset,
                  introStartKeyFrame: widget.iconAssetKeyframes[0],
                  introEndKeyFrame: widget.iconAssetKeyframes[1],
                  hoverStartKeyFrame: widget.iconAssetKeyframes[2],
                  hoverEndKeyFrame: widget.iconAssetKeyframes[3],
                  isSelected: _isSelected,
                  needsReset: _needsReset,
                  canTap: false,
                ),
                suffixIcon: Opacity(
                  opacity: (widget.isPasswordField) ? 1.0 : 0.0,
                  child: AbsorbPointer(
                    absorbing: !widget.isPasswordField,
                    child: TextFieldIcon(
                      canTap: true,
                      asset: widget.unblurIconAsset,
                      introStartKeyFrame: widget.unblurIconAssetKeyframes[0],
                      introEndKeyFrame: widget.unblurIconAssetKeyframes[1],
                      hoverStartKeyFrame: widget.unblurIconAssetKeyframes[2],
                      hoverEndKeyFrame: widget.unblurIconAssetKeyframes[3],
                      isSelected: _shouldBlur,
                      tapCallback: () {
                        setState(() {
                          _shouldBlur = !_shouldBlur;
                        });
                      },
                    ),
                  ),
                ),
                hintText: widget.hint,
                errorText: widget.errorText.isEmpty ? null : widget.errorText,
              ),
              controller: widget.textController,
              onChanged: _onEdit,
            ),
          ),
        ],
      ),
    );
  }
}
