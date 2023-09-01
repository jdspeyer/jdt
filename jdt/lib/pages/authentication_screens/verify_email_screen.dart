import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/pages/authentication_screens/auth_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_button.dart';
import 'package:jdt/pages/authentication_screens/auth_text_field_mini.dart';
import 'package:jdt/pages/authentication_screens/auth_title.dart';
import 'package:jdt/providers/aws_auth_provider.dart';
import 'package:jdt/ui/navbar/navigation.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:jdt/utils/status_enums.dart';

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
  final TextEditingController _confirmEmailController1 =
      TextEditingController();
  final TextEditingController _confirmEmailController2 =
      TextEditingController();
  final TextEditingController _confirmEmailController3 =
      TextEditingController();
  final TextEditingController _confirmEmailController4 =
      TextEditingController();
  final TextEditingController _confirmEmailController5 =
      TextEditingController();

  bool _isLoading = false;
  String _createAccountText = "Verify email";
  bool _isSuccess = false;

  _getCode() {
    return "${_confirmEmailController0.text}${_confirmEmailController1.text}${_confirmEmailController2.text}${_confirmEmailController3.text}${_confirmEmailController4.text}${_confirmEmailController5.text}";
  }

  _confirmEmail() async {
    _isLoading = true;
    setState(() {});
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    final user = await Amplify.Auth.getCurrentUser();
    String email = (user == null) ? "" : user.username;
    print(email);
    VerifyStatus status = await authAWSRepo.confirmSignUp(email, _getCode());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: _isSuccess,
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
                    Form(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AuthTextFieldMini(
                                showIcon: false,
                                isCentered: true,
                                useCharacterLimit: true,
                                hint: "",
                                onEditCallback: (val) {},
                                validationCallback: (val) {
                                  return true;
                                },
                                textController: _confirmEmailController0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: _loadedTheme.innerHorizontalPadding),
                          ),
                          Expanded(
                            child: AuthTextFieldMini(
                                showIcon: false,
                                isCentered: true,
                                useCharacterLimit: true,
                                hint: "",
                                onEditCallback: (val) {},
                                validationCallback: (val) {
                                  return true;
                                },
                                textController: _confirmEmailController1),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: _loadedTheme.innerHorizontalPadding),
                          ),
                          Expanded(
                            child: AuthTextFieldMini(
                                showIcon: false,
                                isCentered: true,
                                useCharacterLimit: true,
                                hint: "",
                                onEditCallback: (val) {},
                                validationCallback: (val) {
                                  return true;
                                },
                                textController: _confirmEmailController2),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: _loadedTheme.innerHorizontalPadding),
                          ),
                          Expanded(
                            child: AuthTextFieldMini(
                                showIcon: false,
                                isCentered: true,
                                useCharacterLimit: true,
                                hint: "",
                                onEditCallback: (val) {},
                                validationCallback: (val) {
                                  return true;
                                },
                                textController: _confirmEmailController3),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: _loadedTheme.innerHorizontalPadding),
                          ),
                          Expanded(
                            child: AuthTextFieldMini(
                                showIcon: false,
                                isCentered: true,
                                useCharacterLimit: true,
                                hint: "",
                                onEditCallback: (val) {},
                                validationCallback: (val) {
                                  return true;
                                },
                                textController: _confirmEmailController4),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: _loadedTheme.innerHorizontalPadding),
                          ),
                          Expanded(
                            child: AuthTextFieldMini(
                                showIcon: false,
                                isCentered: true,
                                useCharacterLimit: true,
                                hint: "",
                                onEditCallback: (val) {},
                                validationCallback: (val) {
                                  return true;
                                },
                                textController: _confirmEmailController5),
                          ),
                        ],
                      ),
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
                          callback: () {},
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
                  callback: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
