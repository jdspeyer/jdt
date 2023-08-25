import 'package:flutter/material.dart';

abstract class JdtIcon extends StatefulWidget {
  JdtIcon({
    super.key,
    required this.asset,
    this.color = Colors.black,
    this.duration = const Duration(milliseconds: 450),
    this.introStartKeyFrame = 0.0,
    this.introEndKeyFrame = 0.0,
    this.hoverStartKeyFrame = 0.0,
    this.hoverEndKeyFrame = 0.0,
    this.shrinkOnClickPercentage = 0.9,
    this.width = 25,
    this.height = 25,
  });

  String asset;
  Color color;

  Duration duration;

  double introStartKeyFrame;
  double introEndKeyFrame;

  double hoverStartKeyFrame;
  double hoverEndKeyFrame;

  double shrinkOnClickPercentage;

  double width;
  double height;

  bool isSelected = false;
}
