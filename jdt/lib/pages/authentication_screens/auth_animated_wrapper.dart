import 'package:flutter/material.dart';
import 'package:jdt/utils/app_window_manager.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class AuthAnimatedWrapper extends StatefulWidget {
  AuthAnimatedWrapper({
    super.key,
    required this.child,
    required this.startingIndex,
    required this.liquidController,
  });

  Widget child;
  LiquidController liquidController;
  int startingIndex;

  @override
  State<AuthAnimatedWrapper> createState() => _AuthAnimatedWrapperState();
}

class _AuthAnimatedWrapperState extends State<AuthAnimatedWrapper> {
  /// Gets the singleton [AppWindowManager]
  final AppWindowManager _appWindowManager = AppWindowManager();

  @override
  Widget build(BuildContext context) {
    return LiquidSwipe(
      pages: [
        widget.child,
        Container(
          width: _appWindowManager.windowSize.width,
          height: _appWindowManager.windowSize.height,
          color: Theme.of(context).cardColor,
        ),
      ],
      liquidController: widget.liquidController,
      disableUserGesture: true,
      initialPage: widget.startingIndex,
      waveType: WaveType.liquidReveal,
    );
  }
}
