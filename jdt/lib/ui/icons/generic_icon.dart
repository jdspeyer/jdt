// ignore_for_file: must_be_immutable, deprecated_member_use
import 'package:jdt/ui/icons/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/* ------------------------------- GenericIcon ------------------------------ */
/// Extends the [JdtIcon] class. [GenericIcon] is an animated icon which has an intro
/// animation which plays on load, and a hover animation. The effect stops when the
/// user clicks on the icon.
class GenericIcon extends JdtIcon {
  GenericIcon({
    super.key,
    required super.asset,
    super.color,
    super.duration,
    super.hoverEndKeyFrame,
    super.hoverStartKeyFrame,
    super.introEndKeyFrame,
    super.introStartKeyFrame,
    super.shrinkOnClickPercentage,
    super.width,
    super.height,
    super.isSelected,
    required this.tapCallback,
    required this.needsReset,
  });

  VoidCallback tapCallback;
  bool needsReset;

  @override
  State<GenericIcon> createState() => _GenericIconState();
}

class _GenericIconState extends State<GenericIcon>
    with TickerProviderStateMixin {
  /// The [AnimationController] for keyframes and general animation playback
  late AnimationController _controller;

  /// The [AnimationController] for controlling size related animation
  late AnimationController _sizeController;

  late Color _strokeColor = Theme.of(context).textTheme.button!.color as Color;

  /// The default value of the [_sizeController]. This is
  /// multiplied by the width and height parameters to calculate the correct size.
  ///
  /// 1 means default size. (x*1 = x)
  double _sizeConstraint = 1;

  /* ------------------------------- hoverEngine ------------------------------ */
  /// A method which is called by the [InkWell] hover callback in the build method.
  /// The [hoverEngine] decides what icon animations should be played and when.
  hoverEngine(bool isHovering) {
    /// The animation is selected. Return and ignore any further instruction.
    if (widget.isSelected) {
      return;
    }

    /// [isHovering] is true, so the user is mousing over the icon.
    /// Play animation. Otherwise, play the animation in reverse.
    if (isHovering) {
      hoverEnterAnimation();
    } else {
      hoverExitAnimation();
    }
  }

  /* --------------------------- hoverEnterAnimation -------------------------- */
  /// Animation which is played during the enterance of a hover.
  hoverEnterAnimation() async {
    _controller.value = widget.hoverStartKeyFrame;
    _controller.animateTo(
      widget.hoverEndKeyFrame,
      duration: widget.duration,
    );
  }

  /* --------------------------- hoverExitAnimation --------------------------- */
  /// Animation which is played during the exit of a hover.
  hoverExitAnimation() async {
    _controller.value = widget.hoverEndKeyFrame;
    _controller.animateTo(
      widget.hoverStartKeyFrame,
      duration: widget.duration,
    );
  }

  /* -------------------------------- tapEngine ------------------------------- */
  /// The [tapEngine] is reposible for handling any tap requests on this icon.
  tapEngine() async {
    await tapAnimation();

    setState(() {
      widget.tapCallback();
    });
  }

  /* ------------------------------ tapAnimation ------------------------------ */
  /// Animation which is played for a tap.
  tapAnimation() async {
    /// Set the value of [_sizeConstraint] to the passed in value.
    setState(() {
      _sizeConstraint = widget.shrinkOnClickPercentage;
    });

    /// Wait for ui to update and for user satisfaction
    await Future.delayed(widget.duration * 0.3);

    /// Undo the animation.
    setState(() {
      _sizeConstraint = 1;
    });
  }

  /* -------------------------------- initState ------------------------------- */
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _sizeController = AnimationController(vsync: this, value: _sizeConstraint);
    super.initState();
  }

  /* --------------------------------- dispose -------------------------------- */
  @override
  void dispose() {
    _controller.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  /* ---------------------------------- build --------------------------------- */
  @override
  Widget build(BuildContext context) {
    if (widget.needsReset) {
      hoverExitAnimation();
      widget.needsReset = false;
      setState(() {});
    }
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Center(
        child: AnimatedContainer(
          curve: Curves.easeInOutCubicEmphasized,
          duration: widget.duration,
          height: widget.height * _sizeConstraint,
          width: widget.width * _sizeConstraint,
          child: InkWell(
            mouseCursor: MouseCursor.defer,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: tapEngine,
            onHover: hoverEngine,
            child: Lottie.asset(
              widget.asset,
              controller: _controller,

              /// onLoaded is called exactly one time when the lottie file
              /// asset has been loaded into the widget (this will not be
              /// recalled for each build). This will run the load animation.
              onLoaded: (composition) async {
                _controller.duration = composition.duration;
                _controller.value = widget.introStartKeyFrame;
                _controller.animateTo(
                  widget.introEndKeyFrame,
                  duration: widget.duration * 2,
                );
                await Future.delayed(widget.duration * 2);
              },

              /// [LottieDelegates] for updating how the lottie should look
              /// Mostly used for themes and selection.
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    const ['**'],
                    value: (!widget.isSelected)
                        ? Theme.of(context).textTheme.button!.color
                        : Theme.of(context).iconTheme.color,
                  ),
                  ValueDelegate.strokeColor(
                    const ['**'],
                    value: (!widget.isSelected)
                        ? Theme.of(context).textTheme.button!.color
                        : Theme.of(context).iconTheme.color,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
