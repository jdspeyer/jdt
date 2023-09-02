import 'package:amplify_api/amplify_api.dart';
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
import 'package:jdt/pages/authentication_screens/signin/signin_screen.dart';
import 'package:jdt/pages/dashboard_screen.dart';
import 'package:jdt/pages/splash_screen/splash_screen.dart';
import 'package:jdt/ui/themes/module_theme.dart';
import 'package:jdt/ui/themes/theme_manager.dart';
import 'package:jdt/utils/app_window_manager.dart';
import 'package:jdt/utils/constants.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ThemeBoxAdapter());
  Hive.registerAdapter(UserBoxAdapter());
  DataManager manager = DataManager();
  AppWindowManager window = AppWindowManager();
  await window.setup();
  await manager.initialize();

  // Create the Auth plugin.
  final auth = AmplifyAuthCognito();

  // Add the plugins and configure Amplify for your app.
  await Amplify.addPlugins([auth]);
  await Amplify.configure(amplifyconfig);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routerDelegate = BeamerDelegate(
    transitionDelegate: NoAnimationTransitionDelegate(),
    initialPath: '/splashscreen',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/splashscreen': (context, state, data) => SplashScreen(),
        '/authentication': (context, state, data) => AuthScreen(),
        '/dashboard/*': (context, state, data) => DashboardScreen(),
      },
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DataManager manager = DataManager();
    ModuleThemeManager themeManager = ModuleThemeManager();
    ModuleTheme selectedTheme =
        manager.getThemeFromStorage('jdt_core_dark_theme');
    themeManager.theme = selectedTheme;
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: selectedTheme.themeData(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
