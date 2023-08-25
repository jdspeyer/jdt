// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:jdt/utils/app_window_manager.dart';
import 'package:jdt/utils/constants.dart';
import 'package:rive/components.dart';
import 'package:rive/rive.dart';

class AnimatedLogo extends StatelessWidget {
  AnimatedLogo({
    super.key,
  });
  AppWindowManager _appWindowManager = AppWindowManager();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _appWindowManager.windowSize.width / 2,
      height: _appWindowManager.windowSize.height / 2,
      child: RiveAnimation.asset(
        logoAssetPath,
        fit: BoxFit.cover,
        stateMachines: const [logoStateMachine],
        artboard: logoArtBoard,
        onInit: (Artboard artboard) {
          artboard.forEachComponent((child) {
            /// Change logo background to match the page.
            if (child is Fill) {
              if (child.paint.color == logoBackgroundColor) {
                child.paint.color = Theme.of(context).primaryColor;
              }
            }

            /// Change strokes/ paths of logo to match the current theme.
            else if (child is Stroke) {
              child.paint.color = Theme.of(context).backgroundColor;
            }

            /// Remove splash elements
            else if (child.name == logoSplashId) {
              (child as Node).opacity = 0;
            }
          });
        },
      ),
    );
  }
}
