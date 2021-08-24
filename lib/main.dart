import 'package:flutter/material.dart';
import 'package:places/models/settings.dart';
import 'package:places/ui/screens/splash_screen.dart';

final settings = Settings();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    settings.addListener(
      () => setState(() {}),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sights',
      theme: settings.getTheme,
      home: const SplashScreen(),
    );
  }
}
