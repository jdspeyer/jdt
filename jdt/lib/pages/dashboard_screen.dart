import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/providers/aws_auth_provider.dart';
import 'package:jdt/ui/navbar/navigation.dart';
import 'package:jdt/ui/navbar/side_navbar.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

import '../ui/themes/module_theme.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  DashboardScreen({super.key});

  /// Path Location
  static const String path = '/dashboard';

  /// Beamer Key for State
  final beamerKey = GlobalKey<BeamerState>();

  /// Beam Page
  static BeamPage beamLocation = BeamPage(
    key: const ValueKey('dashboard'),
    child: DashboardScreen(),
  );

  final routeDelegate = BeamerDelegate(
    removeDuplicateHistory: true,
    transitionDelegate: NoAnimationTransitionDelegate(),
    initialPath: '/dashboard',
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        SettingsLocation(),
      ],
    ),
  );

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
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
    final authAWSRepo = ref.read(authAWSRepositoryProvider);
    authAWSRepo.user;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: _loadedTheme.outerHorizontalPadding,
            right: _loadedTheme.outerHorizontalPadding,
            top: _loadedTheme.outerVerticalPadding),
        child: Row(
          children: [
            SideNavbar(
              width: 55,
              height: MediaQuery.of(context).size.height,
              delegate: widget.routeDelegate,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Beamer(
                  key: widget.beamerKey,
                  routerDelegate: widget.routeDelegate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
