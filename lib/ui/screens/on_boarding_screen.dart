import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/sight_list_screen.dart';

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

class OnboardingScreens extends StatefulWidget {
  final PageController pageController;
  final Function(double page) setCurrentPage;
  final double currentPage;

  const OnboardingScreens({
    Key? key,
    required this.pageController,
    required this.setCurrentPage,
    required this.currentPage,
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
          onPageChanged: (int page) {
            setState(() {
              widget.setCurrentPage(page.toDouble());
            });
          },
          controller: widget.pageController,
          children: [
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
        PageIndicator(currentPage: widget.currentPage),
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  final double currentPage;
  const PageIndicator({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 90,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: i == currentPage ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: i == currentPage
                            ? lightGreen
                            : textColorSecondary.withOpacity(0.56),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
            ],
          ),
          SizedBox(height: (currentPage == 2) ? 32 : 80),
          if (currentPage == 2)
            HomeButton(),
        ],
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil<SightListScreen>(
          context,
          MaterialPageRoute(builder: (context) => SightListScreen()),
          ModalRoute.withName('/Home'),
        );
      },
      child: Container(
        height: 48,
        width: 328,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: lightGreen,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'НА СТАРТ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnboardingAppBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  final double currentPage;
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        if (currentPage != 2)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil<SightListScreen>(
                    context,
                    MaterialPageRoute(builder: (context) => SightListScreen()),
                    ModalRoute.withName('/Home'),
                  );
                },
                child: const Text(
                  'Пропустить',
                  style: TextStyle(
                    color: lightGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class Screen extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const Screen({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          height: 98,
          color: favoriteColor,
        ),
        const SizedBox(height: 40),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: textColorSecondary),
        ),
      ],
    );
  }
}