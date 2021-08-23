import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/sight_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> isInitialized;

  Future<void> _navigateToNext() async {
    return await Future.delayed(
      Duration(seconds: 2),
      () => {
        Navigator.pushAndRemoveUntil<SightListScreen>(
          context,
          MaterialPageRoute(builder: (context) => SightListScreen()),
          ModalRoute.withName('/Home'),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              lightGreen,
              gorse,
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
