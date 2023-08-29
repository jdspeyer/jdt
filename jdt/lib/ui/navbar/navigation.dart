// ignore_for_file: must_be_immutable, annotate_overrides, overridden_fields

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/authentication_screens/signin_screen.dart';
import 'package:jdt/pages/dashboard_screen.dart';
import 'package:jdt/pages/home_screen/home_screen.dart';
import 'package:jdt/pages/setting_screen/settings_screen.dart';
import '../../pages/splash_screen/splash_screen.dart';

/* ---------------------------- DashboardLocation --------------------------- */
/// TODO: Write comment
class DashboardLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      /// Default
      DashboardScreen.beamLocation,
    ];
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => ["${DashboardScreen.path}/*"];
}

/* ------------------------------ HomeLocation ------------------------------ */
/// TODO: Write Comment
class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [HomeScreen.beamLocation];
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => [HomeScreen.path];
}

/* ------------------------------ SettingsLocation ------------------------------ */
/// TODO: Write Comment
class SettingsLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      SettingsScreen.beamLocation,
    ];
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => [SettingsScreen.path];
}

/* ----------------------------- SplashLocation ----------------------------- */
/// TODO: Write comment
class SplashLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      BeamPage(
        key: ValueKey(SplashScreen.beamLocation),
        child: SplashScreen(),
      ),
    ];
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => [SplashScreen.path];
}

/* ----------------------------- SigninLocation ----------------------------- */
/// TODO: Write comment
class SigninLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      BeamPage(
        key: ValueKey(SigninScreen.beamLocation),
        child: SigninScreen(),
      ),
    ];
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => [SigninScreen.path];
}

/* ---------------------------- NoTransitionPage ---------------------------- */
/// Overrides the default behavoir of the [BeamPage] to no longer show a swipe
/// animation. Allows for seamless and quick navigation.
class NoTransitionPage extends BeamPage {
  final Widget child;
  NoTransitionPage({
    required LocalKey key,
    required this.child,
    required this.isEmbelished,
    bool keepQueryOnPop = false,
  }) : super(key: key, child: child, keepQueryOnPop: keepQueryOnPop);

  /// Should the transition be embellished and made beautiful?
  bool isEmbelished;
  @override
  Route createRoute(BuildContext context) {
    print("started");
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
    );
  }
}
