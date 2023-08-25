import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  /// Beam Page
  static BeamPage beamLocation = NoTransitionPage(
    key: ValueKey('dashboard'),
    child: DashboardScreen(),
    isEmbelished: false,
  );

  /// Path Location
  static const String path = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Text("Dashboard"),
      ),
    );
  }
}
