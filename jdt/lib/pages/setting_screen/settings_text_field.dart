import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class SettingsTextField extends StatefulWidget {
  SettingsTextField({
    super.key,
    this.title = "Title",
    this.hint = "Hint",
    this.initialValue = "",
    this.errorText = "Error",
    required this.onEditCallback,
    required this.validationCallback,
    required this.textController,
  });

  String title;
  String hint;
  String initialValue;
  String errorText;
  TextEditingController textController;
  Function(
    String val,
  ) onEditCallback;

  bool Function(
    String val,
  ) validationCallback;

  @override
  State<SettingsTextField> createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  late bool _isValid = true;

  _onEdit(String val) {
    if (widget.validationCallback(widget.textController.text)) {
      _isValid = true;
      setState(() {});

      widget.onEditCallback(widget.textController.text);
    } else {
      _isValid = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(),
      child: Container(
        height: 95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: _loadedTheme.innerVerticalPadding / 4),
            ),
            SizedBox(
              child: TextFormField(
                cursorColor: _loadedTheme.accentColor,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  errorText: _isValid ? null : widget.errorText,
                ),
                controller: widget.textController,
                onChanged: _onEdit,
                //cursorOpacityAnimates: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
