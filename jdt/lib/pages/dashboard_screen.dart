import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/navigation.dart';
import 'package:jdt/ui/navbar/side_navbar.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

import '../ui/themes/module_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  /// Beam Page
  static BeamPage beamLocation = NoTransitionPage(
    key: const ValueKey('dashboard'),
    child: DashboardScreen(),
    isEmbelished: false,
  );

  /// Path Location
  static const String path = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final ModuleThemeManager _manager = ModuleThemeManager();
  late final ModuleTheme _loadedTheme = _manager.currentTheme;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: _loadedTheme.outerHorizontalPadding,
            right: _loadedTheme.outerHorizontalPadding,
            top: _loadedTheme.outerVerticalPadding),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            SideNavbar(
              width: 55,
              height: MediaQuery.of(context).size.height,
            ),
          ],
        ),
      ),
    );
  }
}
