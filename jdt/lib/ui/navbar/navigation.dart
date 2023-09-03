// ignore_for_file: must_be_immutable, annotate_overrides, overridden_fields

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/authentication_screens/auth_screen.dart';
import 'package:jdt/pages/authentication_screens/create/verify_email_screen.dart';
import 'package:jdt/pages/dashboard_screen.dart';
import 'package:jdt/pages/home_screen/home_screen.dart';
import 'package:jdt/pages/setting_screen/settings_screen.dart';
import 'package:jdt/pages/splash_screen/splash_screen.dart';

/* -------------------------------------------------------------------------- */
/*                              DashboardLocation                             */
/* -------------------------------------------------------------------------- */
/// *TOP LEVEL PAGE
/// Stores the location information for the [Beamer] package. Allows navigation to the
/// [DashboardScreen].
class DashboardLocation extends BeamLocation {
  /* ------------------------------- buildPages ------------------------------- */
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      DashboardScreen.beamLocation,
    ];
    return pages;
  }

  /* ------------------------------ pathPatterns ------------------------------ */
  @override
  List<Pattern> get pathPatterns => ["${DashboardScreen.path}/*"];
}

/* -------------------------------------------------------------------------- */
/*                                HomeLocation                                */
/* -------------------------------------------------------------------------- */
/// *SUB PAGE
/// Stores the location information for the [Beamer] package. Allows navigation to the
/// [HomeScreen]. This is a subpage of [DashboardScreen].
class HomeLocation extends BeamLocation {
  /* ------------------------------- buildPages ------------------------------- */
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [HomeScreen.beamLocation];
    return pages;
  }

  /* ------------------------------ pathPatterns ------------------------------ */
  @override
  List<Pattern> get pathPatterns => [HomeScreen.path];
}

/* -------------------------------------------------------------------------- */
/*                              SettingsLocation                              */
/* -------------------------------------------------------------------------- */
/// *SUB PAGE
/// Stores the location information for the [Beamer] package. Allows navigation to the
/// [SettingsScreen]. This is a subpage of [DashboardScreen].
class SettingsLocation extends BeamLocation {
  /* ------------------------------- buildPages ------------------------------- */
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      SettingsScreen.beamLocation,
    ];
    return pages;
  }

  /* ------------------------------ pathPatterns ------------------------------ */
  @override
  List<Pattern> get pathPatterns => [SettingsScreen.path];
}

/* -------------------------------------------------------------------------- */
/*                               SplashLocation                               */
/* -------------------------------------------------------------------------- */
/// *TOP LEVEL PAGE
/// Stores the location information for the [Beamer] package. Allows navigation to the
/// [SplashScreen].
class SplashLocation extends BeamLocation {
  /* ------------------------------- buildPages ------------------------------- */
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

  /* ------------------------------ pathPatterns ------------------------------ */
  @override
  List<Pattern> get pathPatterns => [SplashScreen.path];
}

/* -------------------------------------------------------------------------- */
/*                           AuthenticationLocation                           */
/* -------------------------------------------------------------------------- */
/// *TOP LEVEL PAGE
/// Stores the location information for the [Beamer] package. Allows navigation to the
/// [AuthScreen]. This contains: Sign in, Create Account, Forgot password, and reset password.
class AuthenticationLocation extends BeamLocation {
  /* ------------------------------- buildPages ------------------------------- */
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      BeamPage(
        key: ValueKey(AuthScreen.beamLocation),
        child: AuthScreen(),
      ),
    ];
    return pages;
  }

  /* ------------------------------ pathPatterns ------------------------------ */
  @override
  List<Pattern> get pathPatterns => [AuthScreen.path];
}

/* -------------------------------------------------------------------------- */
/*                             VerifyEmailLocation                            */
/* -------------------------------------------------------------------------- */
/// *TOP LEVEL PAGE
/// Stores the location information for the [Beamer] package. Allows navigation to the
/// [VerifyEmailScreen].
class VerifyEmailLocation extends BeamLocation {
  /* ------------------------------- buildPages ------------------------------- */
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      BeamPage(
        key: ValueKey(VerifyEmailScreen.beamLocation),
        child: VerifyEmailScreen(),
      ),
    ];
    return pages;
  }

  /* ------------------------------ pathPatterns ------------------------------ */
  @override
  List<Pattern> get pathPatterns => [VerifyEmailScreen.path];
}
