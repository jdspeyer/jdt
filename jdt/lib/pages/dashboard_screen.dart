import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/pages/navigation.dart';
import 'package:jdt/ui/icons/generic_icon.dart';
import 'package:lottie/lottie.dart';

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

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

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
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            GenericIcon(
              asset: 'assets/images/lottie/home-icon.rough.json',
              introEndKeyFrame: 0.13,
              introStartKeyFrame: 0.0,
              hoverEndKeyFrame: 1,
              hoverStartKeyFrame: 0.86,
            ),
            GenericIcon(
              asset: 'assets/images/lottie/settings-icon.rough.json',
              introEndKeyFrame: 0.2,
              introStartKeyFrame: 0.0,
              hoverEndKeyFrame: 1,
              hoverStartKeyFrame: 0.7,
            ),
            GenericIcon(
              asset: 'assets/images/lottie/documentation-icon.rough.json',
              introEndKeyFrame: 0.2,
              introStartKeyFrame: 0.0,
              hoverEndKeyFrame: 1,
              hoverStartKeyFrame: 0.82,
              width: 25,
              height: 25,
            ),
            GenericIcon(
              asset: 'assets/images/lottie/add-module-icon.rough.json',
              introEndKeyFrame: 0.2,
              introStartKeyFrame: 0.0,
              hoverEndKeyFrame: 1,
              hoverStartKeyFrame: 0.7,
            ),
          ],
        ),
      ),
    );
  }
}
