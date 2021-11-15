import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/onboarding_screen/page_indicator.dart';
import 'package:places/ui/widgets/onboarding_screen/screen.dart';

class OnboardingScreens extends StatefulWidget {
  final PageController pageController;
  final Function(double page) setCurrentPage;
  final double currentPage;
  final bool fromSettings;

  const OnboardingScreens({
    required this.pageController,
    required this.setCurrentPage,
    required this.currentPage,
    required this.fromSettings,
    Key? key,
  }) : super(key: key);

  @override
  _OnboardingScreensState createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        PageView(
          onPageChanged: (page) {
            setState(() {
              widget.setCurrentPage(page.toDouble());
            });
          },
          controller: widget.pageController,
          children: const [
            Screen(
              icon: iconPointer,
              title: 'Добро пожаловать\nв Путеводитель',
              description: 'Ищи новые локации и сохраняй\nсамые любимые.',
            ),
            Screen(
              icon: iconBackpack,
              title: 'Построй маршрут\nи отправляйся в путь',
              description: 'Достигай цели максимально\nбыстро и комфортно.',
            ),
            Screen(
              icon: iconHandTouch,
              title: 'Добавляй места,\nкоторые нашёл сам',
              description:
                  'Делись самыми интересными\nи помоги нам стать лучше!',
            ),
          ],
        ),
        PageIndicator(
          currentPage: widget.currentPage,
          fromSettings: widget.fromSettings,
        ),
      ],
    );
  }
}
