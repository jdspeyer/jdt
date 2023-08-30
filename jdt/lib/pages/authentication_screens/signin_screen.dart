import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/authentication_screens/auth_button.dart';
import 'package:jdt/pages/authentication_screens/auth_logo.dart';
import 'package:jdt/pages/authentication_screens/auth_text_field.dart';
import 'package:jdt/pages/authentication_screens/auth_title.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({super.key});

  /// [beamLocation] for navigation to the page.
  static final beamLocation = BeamPage(
    key: const ValueKey('signin'),
    child: SigninScreen(),
  );
  final beamerKey = GlobalKey<BeamerState>();

  /// Path Location
  static const String path = '/splashscreen';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(_loadedTheme.cardBorderRadius),
              ),
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
                  AuthTitle(title: "Welcome Back"),
                  Text(
                    "We're so excited to see you again.",
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
                        return false;
                      },
                      textController: TextEditingController()),
                  AuthTextField(
                    iconAsset:
                        'assets/images/lottie/auth-password-icon.rough.json',
                    iconAssetKeyframes: const [0.0, 0.2, 0.4, 0.6],
                    hint: "Password",
                    isPasswordField: true,
                    onEditCallback: (val) {},
                    validationCallback: (val) {
                      return false;
                    },
                    textController: TextEditingController(),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _loadedTheme.innerVerticalPadding)),
                  AuthButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
