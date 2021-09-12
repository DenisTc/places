import 'package:flutter/material.dart';
import 'package:places/dio.dart';
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
    testNetworkCall();
    settings.addListener(
      () => setState(() {}),
    );

    super.initState();
  }

  void testNetworkCall() async{
    final dynamic response = await getDioPosts();

    debugPrint('Response HTTP call = $response');
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
