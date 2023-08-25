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
    super.shrinkOnClickPercentage,
    super.width,
    super.height,
  });

  @override
  State<GenericIcon> createState() => _GenericIconState();
}

class _GenericIconState extends State<GenericIcon>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _sizeController;
  double _sizeConstraint = 1;

  hoverEngine(bool isHovering) {
    if (widget.isSelected) {
      return;
    }

    if (isHovering) {
      hoverEnterAnimation(isHovering);
    } else {
      hoverExitAnimation(isHovering);
    }
  }

  /* --------------------------- hoverEnterAnimation -------------------------- */
  hoverEnterAnimation(event) async {
    _controller.value = widget.hoverStartKeyFrame;
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

  tapAnimation() async {
    setState(() {
      _sizeConstraint = widget.shrinkOnClickPercentage;
    });
    await Future.delayed(widget.duration * 0.3);
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
            onTap: () async {
              widget.isSelected = true;
              await tapAnimation();
              setState(() {});
            },
            onHover: hoverEngine,
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
              },
              delegates: LottieDelegates(
                text: (initialText) => '**$initialText**',
                values: [
                  ValueDelegate.color(
                    // keyPath order: ['layer name', 'group name', 'shape name']
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
