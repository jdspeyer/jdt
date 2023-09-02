// ignore_for_file: unused_result

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/database/data_manager.dart';
import 'package:jdt/database/jdt_user.dart';
import 'package:jdt/pages/authentication_screens/auth_button.dart';
import 'package:jdt/pages/authentication_screens/auth_logo.dart';
import 'package:jdt/pages/authentication_screens/auth_remember_me.dart';
import 'package:jdt/pages/authentication_screens/auth_text_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_field.dart';
import 'package:jdt/pages/authentication_screens/auth_title.dart';
import 'package:jdt/providers/aws_auth_provider.dart';
import 'package:jdt/ui/navbar/navigation.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:jdt/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/utils/status_enums.dart';

class SigninScreen extends ConsumerStatefulWidget {
  SigninScreen({
    super.key,
    required this.forgotPasswordCallback,
    required this.createCallback,
  });

  VoidCallback forgotPasswordCallback;
  VoidCallback createCallback;

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;

  /// Gets the singleton [DataManager]
  final DataManager _dataManager = DataManager();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _signInText = "Sign in";
  String _errorText = "";
  bool _rememberCredentials = false;
  bool _success = false;

  _signin() async {
    _isLoading = true;
    setState(() {});
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    LoginStatus status = await authAWSRepo.signIn(
        _emailController.text, _passwordController.text);
    ref.refresh(authAWSRepositoryProvider);

    switch (status) {
      case LoginStatus.accountDoesNotExistError:
        _signInText = "Sign in";
        _errorText = "Email does not exist.";
        break;
      case LoginStatus.wrongCredentialsError:
        _signInText = "Sign in";
        _errorText = "Email or password was incorrect.";
        break;
      case LoginStatus.unknownError:
        _signInText = "Sign in";
        _errorText = "Unknown error occured.";
        break;
      case LoginStatus.success:
        _signInText = "Success!";
        _errorText = "";
        break;
      case LoginStatus.unconfirmedError:
        _signInText = "Success!";
        _errorText = "";
        break;
      default:
    }

    _isLoading = false;
    setState(() {});

    if (status == LoginStatus.unconfirmedError) {
      _success = true;
      setState(() {});
      _dataManager.saveUserToStorage(JdtUser(
          email: _emailController.text,
          password: _passwordController.text,
          rememberMe: _rememberCredentials));
      await Future.delayed(Duration(seconds: 1));
      Beamer.of(context).beamToReplacement(VerifyEmailLocation());
    }

    if (status == LoginStatus.success) {
      _success = true;
      setState(() {});
      _dataManager.saveUserToStorage(JdtUser(
          email: _emailController.text,
          password: _passwordController.text,
          rememberMe: _rememberCredentials));
      print(_dataManager.getUserFromStorage().email);
      await Future.delayed(Duration(seconds: 1));
      Beamer.of(context).beamToReplacement(DashboardLocation());
    }
  }

  _toggleRememberMe() {
    setState(() {
      _rememberCredentials = !_rememberCredentials;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: (_success || _isLoading),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/Shapes2.png'),
                  fit: BoxFit.cover,
                  scale: 5.0,
                  opacity: (_loadedTheme.brightness == Brightness.dark)
                      ? 0.02
                      : 0.15,
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
                        errorText: _errorText,
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
      ),
    );
  }
}
