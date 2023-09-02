import 'package:flutter/material.dart';

/// The font family which users are allowed to pick their theme icons from.
const String themeBoxFontFamily = "MaterialIcons";

/// The id of the box which contains the saved themes.
const String themeBoxId = "themes";

/// The id of the box which contains the user data stored on the device.
const String userBoxId = "user";

/// The id used to store the currently selected users data on the device
/// This does not change. We only support the currently logged in user.
const String currentUserId = "jdt-current-user";

/// The color which the logo (Hippo) had as its background color by default.
/// This is used to identify it and then replace it with the theme background color.
const Color logoBackgroundColor = Color(0xffffffff);

/// The color which the logo (Hippo) had as its stroke color by default.
/// This is used to identify it and then replace it with the theme stroke color.
const Color logoPathColor = Color(0xff000000);

/// The id of the layer within the logo (Hippo) which contains the splash effects.
/// I cannot for the life of me figure out how to change their color so this is used
/// to identify them and them remove them by lowering their opacity.
const String logoSplashId = 'fsk';

/// The artboard containing the logo (Hippo)
const String logoArtBoard = 'Hippo';

/// The id of the statemachine used to register the eye movement and biting animations of the logo (Hippo).
const String logoStateMachine = 'State Machine 1';

/// The path to the logo (Hippo)
const String logoAssetPath = 'assets/images/logo.riv';
