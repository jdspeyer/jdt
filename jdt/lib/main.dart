import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/amplifyconfiguration.dart';
import 'package:jdt/database/data_manager.dart';
import 'package:jdt/database/themebox.dart';
import 'package:jdt/database/userbox.dart';
import 'package:jdt/pages/authentication_screens/auth_screen.dart';
import 'package:jdt/pages/dashboard_screen.dart';
import 'package:jdt/pages/splash_screen/splash_screen.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:jdt/utils/app_window_manager.dart';

/* ---------------------------------- main ---------------------------------- */
void main() async {
  /// Init Hive
  /// This is used for storing data on the users machine.
  await Hive.initFlutter();

  /// Register adapters here
  /// These are the different "types" of data we will be storing.
  Hive.registerAdapter(ThemeBoxAdapter());
  Hive.registerAdapter(UserBoxAdapter());

  /// The singleton class for managing various data methods.
  DataManager manager = DataManager();
  await manager.initialize();

  /// Sets up sizing attributes of the application window.
  AppWindowManager window = AppWindowManager();
  await window.setup();

  /// Setup Amplify Authentication
  final auth = AmplifyAuthCognito();

  /// Add the plugins that will be used with amplify.
  await Amplify.addPlugins([auth]);
  await Amplify.configure(amplifyconfig);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// [routerDelegate] is where the routes of the Huppo application are defined.
  /// *This only refers to the top level navigation. Sub navigation may be available
  /// *on these pages individually.
  final routerDelegate = BeamerDelegate(
    transitionDelegate: const NoAnimationTransitionDelegate(),
    initialPath: '/splashscreen',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/splashscreen': (context, state, data) => SplashScreen(),
        '/authentication': (context, state, data) => AuthScreen(),
        '/dashboard/*': (context, state, data) => DashboardScreen(),
      },
    ),
  );

  /* ---------------------------------- build --------------------------------- */
  @override
  Widget build(BuildContext context) {
    /// Initialize managers
    DataManager manager = DataManager();
    ModuleThemeManager themeManager = ModuleThemeManager();

    /// Grab the selected theme.
    ModuleTheme selectedTheme =
        manager.getThemeFromStorage('jdt_core_dark_theme');
    themeManager.theme = selectedTheme;

    /// App is contained here
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      debugShowCheckedModeBanner: false,
      title: 'Huppo',
      theme: selectedTheme.themeData(),
    );
  }
}
