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
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordVerifyScreen extends ConsumerStatefulWidget {
  ForgotPasswordVerifyScreen({
    super.key,
    required this.forgotPasswordCallback,
    required this.verifyEmailForPasswordResetCallback,
  });

  VoidCallback forgotPasswordCallback;
  VoidCallback verifyEmailForPasswordResetCallback;

  @override
  ConsumerState<ForgotPasswordVerifyScreen> createState() =>
      _ForgotPasswordVerifyScreenState();
}

class _ForgotPasswordVerifyScreenState
    extends ConsumerState<ForgotPasswordVerifyScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _confirmEmailCode = "";
  bool _isLoading = false;
  bool _success = false;
  String _errorText = "";
  String _createAccountText = "Reset password";

  _confirmIdentity() async {
    _isLoading = true;
    setState(() {});
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    ResetPasswordStatus status = await authAWSRepo.confirmResetPassword(
        newPassword: _passwordController.text,
        confirmationCode: _confirmEmailCode);
    ref.refresh(authAWSRepositoryProvider);

    switch (status) {
      case ResetPasswordStatus.invalidCodeError:
        _errorText = "Incorrect code.";
        break;
      case ResetPasswordStatus.invalidPasswordError:
        _errorText = "Password must be 6 characters.";
        break;
      case ResetPasswordStatus.unknownError:
        _errorText = "Unkown error occured.";
        break;
      case ResetPasswordStatus.limitReachedError:
        _errorText = "Reset limit reached. Try again later.";
        break;
      default:
    }

    if (status != ResetPasswordStatus.success) {
      _createAccountText = "Reset password";
      _isLoading = false;
      setState(() {});
      return;
    }

    _createAccountText = "Password reset!";
    _errorText = "";
    _isLoading = false;
    _success = true;
    setState(() {});
    widget.verifyEmailForPasswordResetCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: (_isLoading || _success),
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
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        width: 95,
                        height: 95,
                        'assets/images/logo/hat.svg',
                        colorFilter: ColorFilter.mode(
                            _loadedTheme.accentColor, BlendMode.srcIn),
                      ),
                    ),
                    AuthTitle(title: "Reset password", suffix: "."),
                    Text(
                      "Input new password and verification below.",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.innerVerticalPadding)),
                    AuthTextField(
                      iconAsset:
                          'assets/images/lottie/auth-password-icon.rough.json',
                      iconAssetKeyframes: const [0.0, 0.2, 0.4, 0.6],
                      hint: "New Password",
                      isPasswordField: true,
                      errorText: _errorText,
                      onEditCallback: (val) {},
                      validationCallback: (val) {
                        return true;
                      },
                      textController: _passwordController,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      hintCharacter: '#',
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        selectedColor: _loadedTheme.accentColor,
                        inactiveColor: _loadedTheme.textColor.withOpacity(0.3),
                        errorBorderColor: _loadedTheme.accentColor,
                        activeColor: _loadedTheme.textColor.withOpacity(0.3),
                        shape: PinCodeFieldShape.box,
                        borderWidth: 1,
                        activeBorderWidth: 1,
                        errorBorderWidth: 1,
                        selectedBorderWidth: 1,
                        disabledBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        borderRadius: BorderRadius.all(
                            Radius.circular(_loadedTheme.cardBorderRadius)),
                        activeFillColor: Colors.white,
                      ),
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: false,
                      controller: _emailController,
                      onCompleted: (v) {},
                      onChanged: (value) {
                        setState(() {
                          _confirmEmailCode = value;
                          _createAccountText = "Reset password";
                        });
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.outerVerticalPadding * 0.6)),
                    AuthButton(
                      text: _createAccountText,
                      width: MediaQuery.of(context).size.width * 0.45,
                      isLoading: _isLoading,
                      height: 45,
                      isDisabled: _confirmEmailCode.length != 6 ||
                          _passwordController.text.isEmpty,
                      callback: _confirmIdentity,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.innerVerticalPadding / 2)),
                    AuthTextButton(
                      text: "Made a mistake? ",
                      linkText: "Try again.",
                      callback: widget.forgotPasswordCallback,
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
