import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:jdt/utils/constants.dart';
import 'package:rive/components.dart';
import 'package:rive/rive.dart';

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
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: _loadedTheme.innerVerticalPadding,
                horizontal: _loadedTheme.innerHorizontalPadding,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(_loadedTheme.cardBorderRadius),
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 400,
                        width: 400,
                        child: RiveAnimation.asset(
                          logoAssetPath,
                          artboard: logoArtBoard,
                          fit: BoxFit.cover,
                          onInit: (Artboard artboard) {
                            artboard.forEachComponent((child) {
                              /// Change logo background to match the page.
                              if (child is Fill) {
                                if (child.paint.color == logoBackgroundColor) {
                                  child.paint.color =
                                      Theme.of(context).cardColor;
                                }
                              }

                              /// Change strokes/ paths of logo to match the current theme.
                              else if (child is Stroke) {
                                child.paint.color =
                                    Theme.of(context).primaryColor;
                              }

                              /// Remove splash elements
                              else if (child.name == logoSplashId) {
                                (child as Node).opacity = 0;
                              }
                            });
                          },
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Sign in',
                          style: Theme.of(context).textTheme.displayLarge,
                          children: <TextSpan>[
                            TextSpan(
                                text: '.',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      color: _loadedTheme.accentColor,
                                      fontSize:
                                          _loadedTheme.titleTextFontSize + 4,
                                    )),
                          ],
                        ),
                      )
                    ],
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
