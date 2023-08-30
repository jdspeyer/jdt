import 'package:flutter/material.dart';
import 'package:jdt/utils/constants.dart';
import 'package:rive/components.dart';
import 'package:rive/rive.dart';

class AuthLogo extends StatefulWidget {
  AuthLogo({
    super.key,
    this.width = 200,
    this.height = 50,
    this.logoDimensions = 350,
  });

  double width;
  double height;
  double logoDimensions;

  @override
  State<AuthLogo> createState() => _AuthLogoState();
}

class _AuthLogoState extends State<AuthLogo> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: LogoClipper(width: widget.width, height: widget.height),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: OverflowBox(
          minWidth: widget.logoDimensions,
          minHeight: widget.logoDimensions,
          maxHeight: widget.logoDimensions,
          maxWidth: widget.logoDimensions,
          child: RiveAnimation.asset(
            logoAssetPath,
            artboard: logoArtBoard,
            fit: BoxFit.cover,
            useArtboardSize: false,
            onInit: (Artboard artboard) {
              artboard.forEachComponent((child) {
                /// Change logo background to match the page.
                if (child is Fill) {
                  if (child.paint.color == logoBackgroundColor) {
                    child.paint.color = Theme.of(context).cardColor;
                  }
                }

                /// Change strokes/ paths of logo to match the current theme.
                else if (child is Stroke) {
                  child.paint.color = Theme.of(context).primaryColor;
                }

                /// Remove splash elements
                else if (child.name == logoSplashId) {
                  (child as Node).opacity = 0;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

class LogoClipper extends CustomClipper<Rect> {
  LogoClipper({
    required this.width,
    required this.height,
  });

  double width;
  double height;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      0,
      0,
      width,
      height,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
