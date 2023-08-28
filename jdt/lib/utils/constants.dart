import 'package:flutter/material.dart';

/// The font family which users are allowed to pick their theme icons from.
const String themeBoxFontFamily = "MaterialIcons";

/// The id of the box which contains the saved themes.
const String themeBoxId = "themes";

const String userBoxId = "user";

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

const String accessKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtidXhxZXdoY3V0ZGVxcGRsZXJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTMyMTA5NDUsImV4cCI6MjAwODc4Njk0NX0.L-D7aLVQ-o9fcFxBBjy8V716SvsqvzLM9L0lTewHrBA';
