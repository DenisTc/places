import 'package:flutter/material.dart';
import 'package:places/ui/widgets/onboarding_screen/onboarding_app_bar.dart';
import 'package:places/ui/widgets/onboarding_screen/onboarding_screens.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void setCurrentPage(double page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnboardingAppBar(currentPage: currentPage),
      body: OnboardingScreens(
        pageController: _pageController,
        setCurrentPage: (page) {
          setCurrentPage(page);
        },
        currentPage: currentPage,
      ),
    );
  }
}
