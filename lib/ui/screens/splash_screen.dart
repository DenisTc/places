import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Future<void> isInitialized;
  late AnimationController _animationController;
  late Animation<double> rotation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    rotation = Tween(begin: 0.0, end: -pi * 2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _animationController.repeat();
    
    try {
      _navigateToNext();
    } on Exception catch (e) {
      debugPrint('Ошибка при переходе на следующий экран: $e');
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              myLightGreen,
              myLightYellow,
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: rotation.value,
                child: SvgPicture.asset(iconSplash, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToNext() async {
    return Future.delayed(
      const Duration(seconds: 3),
      () => {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(fromSettings: false),
          ),
        ),
      },
    ).then(
      (_) => debugPrint('Переход на следующий экран'),
    );
  }
}
