import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/pages/authentication_screens/auth_button.dart';
import 'package:jdt/pages/authentication_screens/auth_logo.dart';
import 'package:jdt/pages/authentication_screens/auth_text_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_field.dart';
import 'package:jdt/pages/authentication_screens/auth_title.dart';
import 'package:jdt/providers/aws_auth_provider.dart';
import 'package:jdt/ui/navbar/navigation.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:jdt/utils/status_enums.dart';

class CreateScreen extends ConsumerStatefulWidget {
  CreateScreen({
    super.key,
    required this.signinCallback,
  });

  VoidCallback signinCallback;

  @override
  ConsumerState<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends ConsumerState<CreateScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _success = false;
  String _createAccountText = "Join the Huppo bloat";
  String _emailErrorText = "";
  String _passwordErrorText = "";

  _createaccount() async {
    _isLoading = true;
    setState(() {});

    if (_passwordController.text != _confirmPasswordController.text) {
      _createAccountText = "Join the Huppo bloat";
      _passwordErrorText = "Passwords do not match.";
      _isLoading = false;
      return;
    }

    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    CreateStatus status = await authAWSRepo.signUp(
        _emailController.text, _passwordController.text);
    ref.refresh(authAWSRepositoryProvider);

    switch (status) {
      case CreateStatus.emailTakenError:
        _createAccountText = "Join the Huppo bloat";
        _emailErrorText = "Email is already in use.";
        break;
      case CreateStatus.invalidPasswordError:
        _createAccountText = "Join the Huppo bloat";
        _passwordErrorText = "Password must be 6 characters.";
        break;
      case CreateStatus.unknownError:
        _createAccountText = "Join the Huppo bloat";
        _emailErrorText = "Unknown error occured.";
        break;
      case CreateStatus.success:
        _createAccountText = "Success!";
        _emailErrorText = "";
      default:
    }

    setState(() {});

    if (status == CreateStatus.success) {
      try {
        _isLoading = false;
        _success = true;
        setState(() {});
        await Future.delayed(Duration(seconds: 1));
        Beamer.of(context).beamToReplacement(VerifyEmailLocation());
      } catch (e) {
        _isLoading = false;
        _success = false;
        _createAccountText = "Join the Huppo bloat";
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: _success,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
                        errorText: _emailErrorText,
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
                      errorText: _passwordErrorText,
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
                      hint: "Confirm password",
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
      ),
    );
  }
}
