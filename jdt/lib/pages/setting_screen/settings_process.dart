import 'package:flutter/material.dart';
import 'package:jdt/database/data_manager.dart';
import 'package:jdt/database/jdt_user.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SettingsProcess extends StatefulWidget {
  SettingsProcess({
    super.key,
    required this.completionAmount,
    required this.completedProfileCallback,
  });

  double completionAmount;
  VoidCallback completedProfileCallback;

  @override
  State<SettingsProcess> createState() => _SettingsProcessState();
}

class _SettingsProcessState extends State<SettingsProcess> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();

  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;

  String _completeToPercent() {
    if (widget.completionAmount == 0.8) {
      widget.completedProfileCallback();
    }

    String percentValue = "";
    percentValue = "${widget.completionAmount * 100}"
        .substring(0, "${widget.completionAmount * 100}".indexOf('.'));
    percentValue = "$percentValue%";
    return percentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(_loadedTheme.cardBorderRadius),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/Shapes.png'),
          fit: BoxFit.cover,
          scale: 2.0,
          opacity: 0.15,
        ),
        color: _loadedTheme.accentColor,
      ),
      padding: EdgeInsets.symmetric(
        vertical: _loadedTheme.innerHorizontalPadding,
        horizontal: _loadedTheme.innerHorizontalPadding,
      ),
      child: Row(
        children: [
          Padding(
            padding:
                EdgeInsets.only(right: _loadedTheme.innerHorizontalPadding),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: _loadedTheme.textColor.withOpacity(0.1),
              ),
              height: 70,
              width: 70,
              child: Stack(
                children: [
                  CircularPercentIndicator(
                    percent: widget.completionAmount,
                    radius: 35,
                    progressColor: _loadedTheme.textColor,
                    lineWidth: 4,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animateFromLastPercent: true,
                    curve: Curves.easeInOutCubicEmphasized,
                    backgroundColor: Colors.transparent,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        _completeToPercent(),
                        style: Theme.of(context).textTheme.displayMedium,
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((widget.completionAmount == 0.8)
                    ? "Profile Completed"
                    : "Completness"),
                Text(
                  (widget.completionAmount == 0.8)
                      ? "Thank you for filling out your profile."
                      : "Fill out your profile for the best experience.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
