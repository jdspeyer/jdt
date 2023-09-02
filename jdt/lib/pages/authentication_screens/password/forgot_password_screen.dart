import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/pages/authentication_screens/auth_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_field.dart';
import 'package:jdt/pages/authentication_screens/auth_title.dart';
import 'package:jdt/providers/aws_auth_provider.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:jdt/utils/status_enums.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  ForgotPasswordScreen({
    super.key,
    required this.signinCallback,
    required this.verifyEmailForResetCallback,
  });

  VoidCallback signinCallback;
  VoidCallback verifyEmailForResetCallback;

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  TextEditingController _emailController = TextEditingController();
  String _errorMessage = "";
  bool _success = false;

  bool _isLoading = false;
  String _createAccountText = "Send reset code";

  _resetaccount() async {
    _isLoading = true;
    setState(() {});
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    VerifyStatus status =
        await authAWSRepo.resetPassword(_emailController.text);
    ref.refresh(authAWSRepositoryProvider);

    if (status == VerifyStatus.incorrect) {
      _createAccountText = "Send reset code";
      _errorMessage = "Email is not in our system.";
      _isLoading = false;
      setState(() {});
      return;
    }

    _createAccountText = "Reset code sent!";
    _errorMessage = "";
    _isLoading = false;
    _success = true;
    setState(() {});
    widget.verifyEmailForResetCallback();
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
                    Center(
                      child: SvgPicture.asset(
                        width: 95,
                        height: 95,
                        'assets/images/logo/confused.svg',
                        colorFilter: ColorFilter.mode(
                            _loadedTheme.accentColor, BlendMode.srcIn),
                      ),
                    ),
                    AuthTitle(title: "Forgot password", suffix: "?"),
                    Text(
                      "You will be back in our bloat in no time!",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.innerVerticalPadding)),
                    AuthTextField(
                        iconAsset:
                            'assets/images/lottie/auth-email-icon.rough.json',
                        iconAssetKeyframes: const [0.0, 0.2, 0.82, 1],
                        hint: "Account email",
                        errorText: _errorMessage,
                        onEditCallback: (val) {},
                        validationCallback: (val) {
                          return true;
                        },
                        textController: _emailController),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.outerVerticalPadding)),
                    AuthButton(
                      text: _createAccountText,
                      width: MediaQuery.of(context).size.width * 0.45,
                      isLoading: _isLoading,
                      height: 45,
                      callback: _resetaccount,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.innerVerticalPadding / 2)),
                    AuthTextButton(
                      text: "Ready to try again? ",
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
