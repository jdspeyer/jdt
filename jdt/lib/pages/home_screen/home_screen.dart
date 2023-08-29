import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jdt/ui/navbar/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  /// [beamLocation] for navigation to the page.
  static final beamLocation = BeamPage(
    key: ValueKey('home'),
    child: HomeScreen(),
  );

  /// Path Location
  static const String path = '/dashboard/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: 50,
        height: 20,
        color: Colors.blue,
      ),
    );
  }
}
