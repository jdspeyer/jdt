import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/authentication_screens/create_screen.dart';
import 'package:jdt/pages/authentication_screens/forgot_password_screen.dart';
import 'package:jdt/pages/authentication_screens/signin_screen.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  /// [beamLocation] for navigation to the page.
  static final beamLocation = BeamPage(
    key: const ValueKey('authentication'),
    child: AuthScreen(),
  );
  final beamerKey = GlobalKey<BeamerState>();

  /// Path Location
  static const String path = '/authentication';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  LiquidController _controller = LiquidController();

  _navigationToSignin() {
    _controller.animateToPage(page: 1);
  }

  _navigationToCreate() {
    _controller.animateToPage(page: 0);
  }

  _navigationToForgotPassword() {
    _controller.animateToPage(page: 2);
  }

  _navigationToVerifyEmail() {
    _controller.jumpToPage(page: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
          CreateScreen(
            signinCallback: _navigationToSignin,
          ),
          SigninScreen(
            forgotPasswordCallback: _navigationToForgotPassword,
            createCallback: _navigationToCreate,
          ),
          ForgotPasswordScreen(
            signinCallback: _navigationToSignin,
          ),
        ],
        liquidController: _controller,
        disableUserGesture: true,
        initialPage: 1,
        waveType: WaveType.liquidReveal,
        ignoreUserGestureWhileAnimating: true,
      ),
    );
  }
}
