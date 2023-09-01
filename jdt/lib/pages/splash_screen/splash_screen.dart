// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/amplifyconfiguration.dart';
import 'package:jdt/database/data_manager.dart';
import 'package:jdt/providers/user_provider.dart';
import 'package:jdt/ui/navbar/navigation.dart';
import 'package:jdt/pages/splash_screen/animated_logo.dart';
import 'package:jdt/utils/app_window_manager.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:percent_indicator/percent_indicator.dart';

/* ------------------------------ SplashScreen ------------------------------ */
/// The [SplashScreen] is where the assets and other loading processes occur while
/// the user is allowed to play with our lil Hippo (he is so cute!).
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  /// [beamLocation] for navigation to the page.
  static final beamLocation = BeamPage(
    key: const ValueKey('splashscreen'),
    child: SplashScreen(),
  );
  final beamerKey = GlobalKey<BeamerState>();

  /// Path Location
  static const String path = '/splashscreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  /// The loading message displayed in title lettering.
  /// Used for macro tasks
  String _loadingTitle = "Loading";

  /// The loading message displayed under the [_loadingTitle].
  /// Used for micro tasks
  String _loadingMessage = "This might take a second...";

  /// Gets the singleton [DataManager]
  final DataManager _dataManager = DataManager();

  /// Gets the singleton [AppWindowManager]
  final AppWindowManager _appWindowManager = AppWindowManager();

  /// The controller used to animation the liquid effect once loading is completed.
  late LiquidController _liquidController;

  /// The hippo animation
  final AnimatedLogo _logo = AnimatedLogo();

  late FutureProvider<AuthUser?> currentUser;

  /// The current loading process of the page.
  /// Range: 0-1
  double _loadingProgress = 0.0;

  /* --------------------------- _loadInApplication --------------------------- */
  /// Loads in various aspects of the application. Each completed task will increase
  /// the [_loadingProgress] bar
  _loadInApplication() async {
    await _dataManagerLoading();
    await _assetLoading();
    await _windowManagerLoading();
    bool authStatus = await _updateChecking();

    /// Loading is now completed! We can tell the user as such.
    setState(() {
      _loadingTitle = 'Welcome to Huppo!';
      _loadingMessage = "You're going to love it here :)";
    });

    /// Animate to the blank page
    _liquidController.animateToPage(
      page: 1,
      duration: 800,
    );

    /// Wait for this animation to occur
    await Future.delayed(const Duration(milliseconds: 1600));

    _dataManager.markAsLoaded();

    if (authStatus) {
      /// Beam the user to the dashboard.
      Beamer.of(context).beamToReplacement(DashboardLocation());
    } else {
      /// Beam the user to the auth screen.
      Beamer.of(context).beamToReplacement(AuthenticationLocation());
    }
  }

  /* --------------------------- _dataManagerLoading -------------------------- */
  /// Loads in all [Hive] boxes and related items from the [DataManager].
  /// Note: This is not going to contain the modules boxes... That will be done
  /// in a different step.
  _dataManagerLoading() async {
    await _dataManager.validateBoxes();
    setState(() {
      _loadingProgress = 0.25;
      _loadingMessage = "Validating storage...";
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /* ------------------------------ _assetLoading ----------------------------- */
  /// Loads in large web assets that were not bundled with the application and other
  /// asset related loading processes.
  _assetLoading() async {
    try {
      setState(() {
        _loadingMessage = "Loading assets...";
      });

      // Success
      safePrint('Successfully configured');
      setState(() {
        _loadingProgress = 0.50;
      });
    } on Exception catch (e) {
      _loadingProgress = 0.0;
      _loadingMessage = "Loading Failed.";
      // Failure
      safePrint('Error configuring Amplify: $e');
    }
  }

  /* -------------------------- _windowManagerLoading ------------------------- */
  /// Ensures that the application window is the right size and that all listeners are
  /// set up.
  _windowManagerLoading() async {
    setState(() {
      _loadingProgress = 0.75;
      _loadingMessage = "Sizing interfaces...";
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /* ----------------------------- _updateChecking ---------------------------- */
  /// Checks for updates made to the software. This is a future feature once the app
  /// is closer to its first release.
  ///
  /// TODO: Finish method and comment.
  Future<bool> _updateChecking() async {
    setState(() {
      _loadingMessage = "Checking authentication...";
    });

    /// 1.) Has the user logged in before and used the remember me feature? If so, this will attempt to log them in using those
    /// credentials.
    if (_hasSavedCredentials()) {
      /// Try login
    }

    /// 2.) Either the saved credentials did not work, they are already logged in, or they dont have an account.
    currentUser = authUserProvider;

    setState(() {
      _loadingProgress = 1;
    });

    /// 3.) The user is not signed in, return false
    if (currentUser.argument == null) {
      /// Has the user signed in previously? Do they have credentials saved on their machine?
      return false;
    }

    return true;
  }

  bool _hasSavedCredentials() {
    return false;
  }

  /* -------------------------------- initState ------------------------------- */
  @override
  void initState() {
    super.initState();

    _liquidController = LiquidController();
    _loadInApplication();
  }

  /* ---------------------------------- build --------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: LiquidSwipe(
          pages: [
            Container(
              color: Theme.of(context).primaryColor,
              width: _appWindowManager.windowSize.width,
              height: _appWindowManager.windowSize.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /* ---------------------------------- Logo ---------------------------------- */
                  Positioned(
                    child: _logo,
                  ),

                  /* ---------------------------- Loading Messages ---------------------------- */
                  Positioned(
                    bottom: _appWindowManager.windowSize.height * 0.30,
                    child: Column(
                      children: [
                        Text(
                          _loadingTitle,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  color: Theme.of(context).backgroundColor),
                        ),
                        Text(
                          _loadingMessage,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).backgroundColor),
                        ),

                        /* ------------------------------- Loading Bar ------------------------------ */
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        SizedBox(
                            width: _appWindowManager.windowSize.width / 4,
                            height: 4,
                            child: (mounted)
                                ? LinearPercentIndicator(
                                    barRadius: const Radius.circular(20),
                                    percent: _loadingProgress,
                                    animateFromLastPercent: true,
                                    animation: true,
                                    progressColor:
                                        Theme.of(context).backgroundColor,
                                    backgroundColor: Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.4),
                                  )
                                : Container()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: _appWindowManager.windowSize.width,
              height: _appWindowManager.windowSize.height,
              color: Theme.of(context).backgroundColor,
            ),
          ],
          liquidController: _liquidController,
          disableUserGesture: true,
          initialPage: 0,
          waveType: WaveType.liquidReveal,
        ));
  }
}
