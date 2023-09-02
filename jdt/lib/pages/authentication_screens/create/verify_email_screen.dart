import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/pages/authentication_screens/auth_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_button.dart';
import 'package:jdt/pages/authentication_screens/auth_title.dart';
import 'package:jdt/providers/aws_auth_provider.dart';
import 'package:jdt/ui/navbar/navigation.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:jdt/utils/status_enums.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  VerifyEmailScreen({
    super.key,
  });

  /// [beamLocation] for navigation to the page.
  static final beamLocation = BeamPage(
    key: const ValueKey('verifyemail'),
    child: VerifyEmailScreen(),
  );
  final beamerKey = GlobalKey<BeamerState>();

  /// Path Location
  static const String path = '/verifyemail';

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;
  final TextEditingController _confirmEmailController0 =
      TextEditingController();
  String confirmEmailCode = "";

  bool _isLoading = false;
  String _createAccountText = "Verify email";
  bool _isSuccess = false;

  _getCode() {
    return confirmEmailCode;
  }

  _confirmEmail() async {
    _isLoading = true;
    setState(() {});
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    VerifyStatus status = await authAWSRepo.confirmSignUp(_getCode());
    ref.refresh(authAWSRepositoryProvider);

    if (status == VerifyStatus.incorrect) {
      _createAccountText = "Incorrect code";
      _isLoading = false;
      setState(() {});
      return;
    }

    _createAccountText = "Success!";
    _isSuccess = true;
    _isLoading = false;
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    Beamer.of(context).beamToReplacement(DashboardLocation());
  }

  _resendEmail() async {
    _isLoading = true;
    setState(() {});
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    VerifyStatus status = await authAWSRepo.resendConfirmSignUpEmail();
    ref.refresh(authAWSRepositoryProvider);

    if (status == VerifyStatus.incorrect) {
      _createAccountText = "Error sending code";
      _isLoading = false;
      setState(() {});
      return;
    }

    _createAccountText = "Code sent";
    _isLoading = false;
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: (_isSuccess || _isLoading),
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
                        'assets/images/logo/celebrate.svg',
                        colorFilter: ColorFilter.mode(
                            _loadedTheme.accentColor, BlendMode.srcIn),
                      ),
                    ),
                    AuthTitle(title: "You're almost there", suffix: "!"),
                    Text(
                      "We sent a verification code to your email.",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.innerVerticalPadding)),

                    /* ------------------------------- EMAIL FORM ------------------------------- */
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        selectedColor: _loadedTheme.accentColor,
                        inactiveColor: _loadedTheme.textColor.withOpacity(0.3),
                        errorBorderColor: _loadedTheme.accentColor,
                        activeColor: _loadedTheme.textColor.withOpacity(0.3),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.all(
                            Radius.circular(_loadedTheme.cardBorderRadius)),
                        activeFillColor: Colors.white,
                      ),
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: false,
                      controller: _confirmEmailController0,
                      onCompleted: (v) {},
                      onChanged: (value) {
                        setState(() {
                          confirmEmailCode = value;
                          _createAccountText = "Verify email";
                        });
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.outerVerticalPadding)),
                    AuthButton(
                      text: _createAccountText,
                      width: MediaQuery.of(context).size.width * 0.45,
                      isLoading: _isLoading,
                      height: 45,
                      callback: _confirmEmail,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _loadedTheme.innerVerticalPadding / 2)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthTextButton(
                          text: "Didn't get an email?",
                          linkText: " Resend code.",
                          callback: _resendEmail,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: _loadedTheme.outerVerticalPadding * 0.25)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: _loadedTheme.outerVerticalPadding * 0.25),
                child: AuthTextButton(
                  text: "",
                  linkText: "Sign out.",
                  callback: () {
                    Beamer.of(context)
                        .beamToReplacement(AuthenticationLocation());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
