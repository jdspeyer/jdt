import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/authentication_screens/auth_button.dart';
import 'package:jdt/pages/authentication_screens/auth_logo.dart';
import 'package:jdt/pages/authentication_screens/auth_text_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_field.dart';
import 'package:jdt/pages/authentication_screens/auth_title.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({
    super.key,
    required this.signinCallback,
  });

  VoidCallback signinCallback;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String _createAccountText = "Join The Huppo Bloat";

  _createaccount() async {
    _isLoading = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 5));
    _createAccountText = "Success!";
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              image: DecorationImage(
                image: AssetImage('assets/images/Shapes2.png'),
                fit: BoxFit.cover,
                scale: 5.0,
                opacity:
                    (_loadedTheme.brightness == Brightness.dark) ? 0.02 : 0.15,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              padding: EdgeInsets.symmetric(
                vertical: _loadedTheme.innerVerticalPadding * 2,
                horizontal: _loadedTheme.innerHorizontalPadding * 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(_loadedTheme.cardBorderRadius),
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: AuthLogo()),
                  AuthTitle(title: "Create account"),
                  Text(
                    "We're so excited to have you in our bloat!",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _loadedTheme.innerVerticalPadding)),
                  AuthTextField(
                      iconAsset:
                          'assets/images/lottie/auth-email-icon.rough.json',
                      iconAssetKeyframes: const [0.0, 0.2, 0.82, 1],
                      hint: "Email",
                      onEditCallback: (val) {},
                      validationCallback: (val) {
                        return true;
                      },
                      textController: _emailController),
                  AuthTextField(
                    iconAsset:
                        'assets/images/lottie/auth-password-icon.rough.json',
                    iconAssetKeyframes: const [0.0, 0.2, 0.4, 0.6],
                    hint: "Password",
                    isPasswordField: true,
                    onEditCallback: (val) {},
                    validationCallback: (val) {
                      return true;
                    },
                    textController: _passwordController,
                  ),
                  AuthTextField(
                    iconAsset:
                        'assets/images/lottie/auth-password-icon.rough.json',
                    iconAssetKeyframes: const [0.0, 0.2, 0.4, 0.6],
                    hint: "Confirm Password",
                    isPasswordField: true,
                    onEditCallback: (val) {},
                    validationCallback: (val) {
                      return true;
                    },
                    textController: _confirmPasswordController,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _loadedTheme.outerVerticalPadding)),
                  AuthButton(
                    text: _createAccountText,
                    width: MediaQuery.of(context).size.width * 0.45,
                    isLoading: _isLoading,
                    height: 45,
                    callback: _createaccount,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _loadedTheme.innerVerticalPadding / 2)),
                  AuthTextButton(
                    text: "Already in the bloat? ",
                    linkText: "Sign in.",
                    callback: widget.signinCallback,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
