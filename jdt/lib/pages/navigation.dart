// ignore_for_file: must_be_immutable, annotate_overrides, overridden_fields

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/dashboard_screen.dart';
import 'splash_screen/splash_screen.dart';

/* ---------------------------- DashboardLocation --------------------------- */
/// TODO: Write comment
class DashboardLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      DashboardScreen.beamLocation,
    ];
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => [DashboardScreen.path];
}

/* ----------------------------- SplashLocation ----------------------------- */
/// TODO: Write comment
class SplashLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      const BeamPage(
        key: ValueKey(SplashScreen.beamLocation),
        child: SplashScreen(),
      ),
    ];
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => [SplashScreen.path];
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
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
    );
  }
}
