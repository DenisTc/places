import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> isInitialized;

  Future<void> _navigateToNext() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        ),
      },
    ).then(
      (_) => debugPrint('Переход на следующий экран'),
    );
  }

  @override
  void initState() {
    super.initState();

    try {
      _navigateToNext();
    } catch (e) {
      debugPrint('Ошибка при переходе на следующий экран: $e');
    }
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
          child: SvgPicture.asset(iconSplash, color: Colors.white),
        ),
      ),
    );
  }
}
