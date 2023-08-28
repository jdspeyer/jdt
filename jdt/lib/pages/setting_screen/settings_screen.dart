import 'package:beamer/beamer.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:jdt/database/data_manager.dart';
import 'package:jdt/database/jdt_user.dart';
import 'package:jdt/pages/setting_screen/settings_confetti.dart';
import 'package:jdt/pages/setting_screen/settings_process.dart';
import 'package:jdt/pages/setting_screen/settings_text_field.dart';
import 'package:jdt/pages/setting_screen/settings_text_field_header.dart';
import 'package:jdt/ui/themes/jdt_divider.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  /// [beamLocation] for navigation to the page.
  static final beamLocation = BeamPage(
    key: ValueKey('settings'),
    child: SettingsScreen(),
  );

  /// Path Location
  static const String path = '/dashboard/settings';

  final DataManager _dataManager = DataManager();
  late final JdtUser _currentUser = _dataManager.getUserFromStorage();
  late ConfettiController _controllerTopCenter;

  late final TextEditingController _fNameTextController = TextEditingController(
    text: _currentUser.firstName,
  );
  late final TextEditingController _lNameTextController = TextEditingController(
    text: _currentUser.lastName,
  );
  late final TextEditingController _emailTextController = TextEditingController(
    text: _currentUser.email,
  );
  late final TextEditingController _numberTextController =
      TextEditingController(
    text: "${_currentUser.phoneNumber}",
  );

  late double _completionPercent = _currentUser.getProfileEditCompletion();

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ModuleThemeManager _themeManager = ModuleThemeManager();

  late final ModuleTheme _loadedTheme = _themeManager.currentTheme;

  bool _validateFirstName(String val) {
    widget._completionPercent = widget._currentUser.getProfileEditCompletion();
    setState(() {});
    return val.isNotEmpty;
  }

  bool _validateLastName(String val) {
    widget._completionPercent = widget._currentUser.getProfileEditCompletion();
    setState(() {});
    return true;
  }

  bool _validateEmail(String val) {
    widget._completionPercent = widget._currentUser.getProfileEditCompletion();
    setState(() {});
    return true;
  }

  bool _validatePhoneNumber(String val) {
    widget._completionPercent = widget._currentUser.getProfileEditCompletion();
    setState(() {});
    return true;
  }

  _setupCompleted() async {
    if (!widget._dataManager.getUserFromStorage().hasFinishedProfileSetup) {
      widget._currentUser.setProfileCompletion();
      widget._controllerTopCenter.play();
      await Future.delayed(Duration(seconds: 3));
      widget._controllerTopCenter.stop();
    }
    print("ran");
  }

  @override
  void initState() {
    super.initState();

    widget._controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: _loadedTheme.outerHorizontalPadding,
            ),
            child: Row(
              children: [
                /* ---------------------------- Account Settings ---------------------------- */
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: _loadedTheme.innerVerticalPadding,
                      horizontal: _loadedTheme.innerHorizontalPadding,
                    ),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_loadedTheme.cardBorderRadius),
                        bottomLeft:
                            Radius.circular(_loadedTheme.cardBorderRadius),
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account Settings",
                          style: Theme.of(context).textTheme.displayMedium!,
                        ),
                        JdtDivider(
                          abovePadding: _loadedTheme.innerVerticalPadding,
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              /* --------------------------------- Header --------------------------------- */
                              SettingsTextFieldHeader(
                                title: "Personal Information",
                                subtitle:
                                    "This is personal information related to you.",
                              ),

                              /* ------------------------------ Name Settings ----------------------------- */
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: SettingsTextField(
                                      title: "First Name",
                                      hint: "John",
                                      onEditCallback:
                                          widget._currentUser.setFirstName,
                                      validationCallback: _validateFirstName,
                                      initialValue:
                                          widget._currentUser.firstName,
                                      errorText: "Name required.",
                                      textController:
                                          widget._fNameTextController,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right:
                                          _loadedTheme.innerHorizontalPadding,
                                    ),
                                  ),
                                  Expanded(
                                    child: SettingsTextField(
                                      title: "Last Name",
                                      hint: "Smith",
                                      onEditCallback:
                                          widget._currentUser.setLastName,
                                      validationCallback: _validateLastName,
                                      initialValue:
                                          widget._currentUser.lastName,
                                      textController:
                                          widget._lNameTextController,
                                    ),
                                  ),
                                ],
                              ),

                              /* ----------------------------- Email Settings ----------------------------- */
                              SettingsTextField(
                                title: "Email",
                                hint: "JohnSmith@mail.com",
                                onEditCallback: widget._currentUser.setEmail,
                                validationCallback: _validateEmail,
                                initialValue: widget._currentUser.email,
                                textController: widget._emailTextController,
                              ),

                              /* -------------------------- Phone Number Settings ------------------------- */
                              SettingsTextField(
                                title: "Phone Number",
                                hint: "11234567890",
                                onEditCallback:
                                    widget._currentUser.setPhoneNumber,
                                validationCallback: _validatePhoneNumber,
                                initialValue:
                                    "${widget._currentUser.phoneNumber}",
                                textController: widget._numberTextController,
                              ),

                              /* -------------------------- Toggle Options Header ------------------------- */
                              JdtDivider(
                                abovePadding: _loadedTheme.innerVerticalPadding,
                              ),
                              SettingsTextFieldHeader(
                                title: "Privacy Settings",
                                subtitle:
                                    "What would you like modules to have access to?",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: _loadedTheme.outerHorizontalPadding / 4,
                  ),
                ),

                /* ---------------------------- Software Settings --------------------------- */
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(
                    vertical: _loadedTheme.innerVerticalPadding,
                    horizontal: _loadedTheme.innerHorizontalPadding,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(_loadedTheme.cardBorderRadius),
                      bottomRight:
                          Radius.circular(_loadedTheme.cardBorderRadius),
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Settings",
                        style: Theme.of(context).textTheme.displayMedium!,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: _loadedTheme.innerVerticalPadding,
                              ),
                            ),
                            SettingsProcess(
                                completedProfileCallback: _setupCompleted,
                                completionAmount: widget._completionPercent),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: widget._controllerTopCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  false, // start again as soon as the animation is finished
              colors: [
                _loadedTheme.accentColor,
                _loadedTheme.textColor,
                _loadedTheme.iconColor,
              ], // manually specify the colors to be used
            ),
          ),
        ],
      ),
    );
  }
}
