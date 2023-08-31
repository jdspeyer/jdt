import 'package:flutter/material.dart';
import 'package:jdt/pages/authentication_screens/auth_button.dart';
import 'package:jdt/pages/authentication_screens/auth_logo.dart';
import 'package:jdt/pages/authentication_screens/auth_remember_me.dart';
import 'package:jdt/pages/authentication_screens/auth_text_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_field.dart';
import 'package:jdt/pages/authentication_screens/auth_title.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({
    super.key,
    required this.forgotPasswordCallback,
    required this.createCallback,
  });

  VoidCallback forgotPasswordCallback;
  VoidCallback createCallback;

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _signInText = "Sign in";
  bool _rememberCredentials = false;

  _signin() async {
    _isLoading = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 5));
    _signInText = "Success!";
    _isLoading = false;
    setState(() {});
  }

  _toggleRememberMe() {
    setState(() {
      _rememberCredentials = !_rememberCredentials;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
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
                  AuthTitle(title: "Welcome back"),
                  Text(
                    "The bloat awaits!",
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
                  AuthRememberMe(
                    remember: _rememberCredentials,
                    rememberMeCallback: _toggleRememberMe,
                    forgotPasswordCallback: widget.forgotPasswordCallback,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _loadedTheme.outerVerticalPadding)),
                  AuthButton(
                    text: _signInText,
                    width: MediaQuery.of(context).size.width * 0.45,
                    isLoading: _isLoading,
                    height: 45,
                    callback: _signin,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _loadedTheme.innerVerticalPadding / 2)),
                  AuthTextButton(
                    text: "New here? ",
                    linkText: "Create a free account.",
                    callback: widget.createCallback,
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
