import 'package:flutter/material.dart';
import 'package:places/ui/widgets/onboarding_screen/onboarding_app_bar.dart';
import 'package:places/ui/widgets/onboarding_screen/onboarding_screens.dart';

class OnboardingScreen extends StatefulWidget {
  final bool fromSettings;
  const OnboardingScreen({
    required this.fromSettings,
    Key? key,
  }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  double currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: OnboardingAppBar(
        currentPage: currentPage,
        fromSettings: widget.fromSettings,
      ),
      body: OnboardingScreens(
        pageController: _pageController,
        setCurrentPage: (page) {
          setCurrentPage(page);
        },
        currentPage: currentPage,
        fromSettings: widget.fromSettings,
      ),
    );
  }

  void setCurrentPage(double page) {
    setState(() {
      currentPage = page;
    });
  }
}
