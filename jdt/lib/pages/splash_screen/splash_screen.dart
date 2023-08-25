// ignore_for_file: deprecated_member_use

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/database/data_manager.dart';
import 'package:jdt/pages/navigation.dart';
import 'package:jdt/pages/splash_screen/animated_logo.dart';
import 'package:jdt/utils/app_window_manager.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const beamLocation = BeamPage(
    key: ValueKey('splashscreen'),
    child: SplashScreen(),
  );

  /// Path Location
  static const String path = '/splashscreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String _loadingTitle = "Loading";
  String _loadingMessage = "This might take a second...";
  final DataManager _dataManager = DataManager();
  final AppWindowManager _appWindowManager = AppWindowManager();
  late LiquidController _liquidController;
  AnimatedLogo _logo = AnimatedLogo();
  double _loadingProgress = 0.0;

  _loadInApplication() async {
    await _dataManagerLoading();
    await _assetLoading();
    await _windowManagerLoading();
    await _updateChecking();
    setState(() {
      _loadingTitle = 'Complete!';
      _loadingMessage = "Thank you for waiting!";
    });

    _liquidController.animateToPage(
      page: 1,
      duration: 800,
    );
    await Future.delayed(Duration(milliseconds: 1600));

    Beamer.of(context).beamTo(DashboardLocation());
  }

  _dataManagerLoading() async {
    await _dataManager.validateBoxes();
    setState(() {
      _loadingProgress = 0.25;
      _loadingMessage = "Validating storage...";
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  _assetLoading() async {
    setState(() {
      _loadingProgress = 0.50;
      _loadingMessage = "Loading assets...";
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  _windowManagerLoading() async {
    setState(() {
      _loadingProgress = 0.75;
      _loadingMessage = "Sizing interfaces...";
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  _updateChecking() async {
    setState(() {
      _loadingProgress = 1;
      _loadingMessage = "Checking for updates...";
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void initState() {
    super.initState();

    _liquidController = LiquidController();
    _loadInApplication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: LiquidSwipe(
          pages: [
            Container(
              color: Theme.of(context).primaryColor,
              width: _appWindowManager.windowSize.width,
              height: _appWindowManager.windowSize.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: _logo,
                  ),
                  Positioned(
                    bottom: _appWindowManager.windowSize.height * 0.30,
                    child: Column(
                      children: [
                        Text(
                          "$_loadingTitle",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  color: Theme.of(context).backgroundColor),
                        ),
                        Text(
                          "$_loadingMessage",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).backgroundColor),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        SizedBox(
                            width: _appWindowManager.windowSize.width / 4,
                            height: 4,
                            child: LinearPercentIndicator(
                              barRadius: Radius.circular(20),
                              percent: _loadingProgress,
                              animateFromLastPercent: true,
                              animation: true,
                              progressColor: Theme.of(context).backgroundColor,
                              backgroundColor: Theme.of(context)
                                  .backgroundColor
                                  .withOpacity(0.4),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: _appWindowManager.windowSize.width,
              height: _appWindowManager.windowSize.height,
              color: Theme.of(context).backgroundColor,
            ),
          ],
          liquidController: _liquidController,
          disableUserGesture: true,
          initialPage: 0,
          waveType: WaveType.liquidReveal,
        ));
  }
}
