import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screens/home.dart';

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
  final SharedStorage _storage = SharedStorage();
  double currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _storage.setOnboardingStatus();
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
              title: constants.textOnboardingScreenFirstTitle,
              description: constants.textOnboardingScreenFirstDesc,
            ),
            Screen(
              icon: iconBackpack,
              title: constants.textOnboardingScreenSecondTitle,
              description: constants.textOnboardingScreenSecondDesc,
            ),
            Screen(
              icon: iconHandTouch,
              title: constants.textOnboardingScreenThirdTitle,
              description: constants.textOnboardingScreenThirdDesc,
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

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double currentPage;
  final bool fromSettings;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  const OnboardingAppBar({
    required this.currentPage,
    required this.fromSettings,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = fromSettings ? 3 : 0;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        if (currentPage != 2)
          TextButton(
            onPressed: () {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(selectedTab: index),
                ),
              );
            },
            child: Text(
              constants.textBtnSkip,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

class Screen extends StatefulWidget {
  final String icon;
  final String title;
  final String description;

  const Screen({
    required this.icon,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _sizeAnimation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SizedBox(
                height: 100,
                child: SvgPicture.asset(
                  widget.icon,
                  height: _sizeAnimation.value,
                  color: Theme.of(context).iconTheme.color,
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: myLightSecondaryTwo),
          ),
        ],
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final double currentPage;
  final bool fromSettings;
  const PageIndicator({
    required this.currentPage,
    required this.fromSettings,
    Key? key,
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
                            ? Theme.of(context).colorScheme.primaryVariant
                            : myLightSecondaryTwo.withOpacity(0.56),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
            ],
          ),
          SizedBox(height: (currentPage == 2) ? 32 : 80),
          if (currentPage == 2) HomeButton(fromSettings: fromSettings),
        ],
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final bool fromSettings;
  const HomeButton({
    required this.fromSettings,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = fromSettings ? 3 : 0;

    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => Home(selectedTab: index),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.primaryVariant,
        fixedSize: const Size(328, 48),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        constants.textBtnStart,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
