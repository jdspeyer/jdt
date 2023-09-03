// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

/* --------------------------------- JdtIcon -------------------------------- */
/// [JdtIcon] is an abstract class which extends [StatefulWidget] to build dynamic
/// and interactive icons which animate during various actions.
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
    this.isSelected = false,
  });

  /// A string containing a path to the lottie asset.
  String asset;

  /// An optional color parameter which can be used by implementations if necessary.
  Color color;

  /// The duration of the animations.
  /// This refers to the time it takes to progress from one key frame to another.
  Duration duration;

  /// The keyframe for the start of the intro animation.
  /// This should be a [double] that fufills: `0 <= x <= 1`
  double introStartKeyFrame;

  /// The keyframe for the end of the intro animation.
  /// This should be a [double] that fufills: `0 <= x <= 1`
  double introEndKeyFrame;

  /// The keyframe for the start of the hover animation.
  /// This should be a [double] that fufills: `0 <= x <= 1`
  double hoverStartKeyFrame;

  /// The keyframe for the end of the intro animation.
  /// This should be a [double] that fufills: `0 <= x <= 1`
  double hoverEndKeyFrame;

  /// The percentage expressed as a [double] that the icon
  /// should shrink to become when a click occurs.
  ///
  /// This should be a [double] that fufills: `0 <= x <= 1`
  /// 0.9 would be 90% of the size passed in calculated as [width]*[shrinkOnClickPercentage]
  double shrinkOnClickPercentage;

  /// The width of the icon
  double width;

  /// The height of the icon
  double height;

  /// Is this icon selected/ toggled on?
  bool isSelected;
}
