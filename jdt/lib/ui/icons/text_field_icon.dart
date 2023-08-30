// ignore_for_file: must_be_immutable, deprecated_member_use
import 'package:flutter/foundation.dart';
import 'package:jdt/ui/icons/jdt_icon.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/* ------------------------------- TextFieldIcon ------------------------------ */
/// Extends the [JdtIcon] class. [TextFieldIcon] is an icon designed to animate to a position
/// while the user types and then un animate from that position when the user stops typing.
class TextFieldIcon extends JdtIcon {
  TextFieldIcon({
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
    this.needsReset = false,
    this.canTap = false,
    this.tapCallback,
  });
  bool needsReset;
  bool canTap;
  VoidCallback? tapCallback;

  @override
  State<TextFieldIcon> createState() => _GenericIconState();
}

class _GenericIconState extends State<TextFieldIcon>
    with TickerProviderStateMixin {
  /// The [AnimationController] for keyframes and general animation playback
  late AnimationController _controller;

  /// The [AnimationController] for controlling size related animation
  late AnimationController _sizeController;

  /// The default value of the [_sizeController]. This is
  /// multiplied by the width and height parameters to calculate the correct size.
  ///
  /// 1 means default size. (x*1 = x)
  double _sizeConstraint = 1;

  bool _isTyping = false;

  /* --------------------------- typingStartAnimation -------------------------- */
  /// Animation which is played when the user clicks the associated text box and starts typing.
  typingStartAnimation() async {
    _isTyping = true;
    if (_controller.value != widget.hoverEndKeyFrame) {
      _controller.value = widget.hoverStartKeyFrame;
      _controller.animateTo(
        widget.hoverEndKeyFrame,
        duration: widget.duration,
      );
    }
  }

  /* --------------------------- typingEndAnimation --------------------------- */
  /// Animation which is played when the user exits the text box.
  typingEndAnimation() async {
    if (_controller.value != widget.hoverStartKeyFrame) {
      _controller.value = widget.hoverEndKeyFrame;
      _controller.animateTo(
        widget.hoverStartKeyFrame,
        duration: widget.duration,
      );
      _isTyping = false;
    }
  }

  /* -------------------------------- tapEngine ------------------------------- */
  /// The [tapEngine] is reposible for handling any tap requests on this icon.
  tapEngine() async {
    if (widget.canTap) {
      await tapAnimation();

      setState(() {
        try {
          widget.tapCallback!();
        } catch (e) {
          if (kDebugMode) {
            print("Error occured.");
          }
        }
      });
    }
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
    if (widget.isSelected && !_isTyping) {
      typingStartAnimation();
    } else if (!widget.isSelected && _isTyping) {
      typingEndAnimation();
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
                    value: (widget.isSelected && widget.canTap)
                        ? Theme.of(context).iconTheme.color
                        : Theme.of(context).textTheme.button!.color,
                  ),
                  ValueDelegate.strokeColor(
                    const ['**'],
                    value: (widget.isSelected && widget.canTap)
                        ? Theme.of(context).iconTheme.color
                        : Theme.of(context).textTheme.button!.color,
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
