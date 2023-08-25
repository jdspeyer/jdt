import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/dashboard_screen.dart';
import 'splash_screen/splash_screen.dart';

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

class NoTransitionPage extends BeamPage {
  final Widget child;
  NoTransitionPage({
    required LocalKey key,
    required this.child,
    required this.isEmbelished,
    bool keepQueryOnPop = false,
  }) : super(key: key, child: child, keepQueryOnPop: keepQueryOnPop);

  bool isEmbelished;
  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
    );
  }
}
