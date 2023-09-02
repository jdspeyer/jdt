import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/authentication_screens/create/create_screen.dart';
import 'package:jdt/pages/authentication_screens/password/forgot_password_screen.dart';
import 'package:jdt/pages/authentication_screens/password/forgot_password_verify_screen.dart';
import 'package:jdt/pages/authentication_screens/signin/signin_screen.dart';
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

  _navigationToVerifyEmailForPassword() {
    _controller.animateToPage(page: 3);
  }

  _jumpToSignin() {
    _controller.animateToPage(page: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
          /// Create account screen
          CreateScreen(
            signinCallback: _navigationToSignin,
          ),

          /// Sign in screen
          SigninScreen(
            forgotPasswordCallback: _navigationToForgotPassword,
            createCallback: _navigationToCreate,
          ),

          /// Forgot Password Screens
          ForgotPasswordScreen(
            signinCallback: _navigationToSignin,
            verifyEmailForResetCallback: _navigationToVerifyEmailForPassword,
          ),
          ForgotPasswordVerifyScreen(
            forgotPasswordCallback: _navigationToForgotPassword,
            verifyEmailForPasswordResetCallback: _jumpToSignin,
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
