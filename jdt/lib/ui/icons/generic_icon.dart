import 'package:jdt/ui/icons/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
  });

  @override
  State<GenericIcon> createState() => _GenericIconState();
}

class _GenericIconState extends State<GenericIcon>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  /* --------------------------- hoverEnterAnimation -------------------------- */
  hoverEnterAnimation(event) async {
    _controller.value = widget.hoverStartKeyFrame;

    await Future.delayed(widget.duration);

    _controller.animateTo(
      widget.hoverEndKeyFrame,
      duration: widget.duration,
    );
  }

  /* --------------------------- hoverExitAnimation --------------------------- */
  hoverExitAnimation(event) async {
    _controller.value = widget.hoverEndKeyFrame;

    _controller.animateTo(
      widget.hoverStartKeyFrame,
      duration: widget.duration,
    );
  }

  /* -------------------------------- initState ------------------------------- */
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  /* --------------------------------- dispose -------------------------------- */
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /* ---------------------------------- build --------------------------------- */
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: hoverEnterAnimation,
      onExit: hoverExitAnimation,
      child: GestureDetector(
        child: Lottie.asset(
          widget.asset,
          controller: _controller,
          onLoaded: (composition) async {
            _controller.duration = composition.duration;
            _controller.value = widget.introStartKeyFrame;
            _controller.animateTo(
              widget.introEndKeyFrame,
              duration: widget.duration * 2,
            );
            await Future.delayed(widget.duration * 2);
            widget.isLoaded = true;
          },
        ),
      ),
    );
  }
}
