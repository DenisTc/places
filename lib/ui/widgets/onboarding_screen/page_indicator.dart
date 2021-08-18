import 'package:flutter/material.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/widgets/onboarding_screen/home_button.dart';

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
          if (currentPage == 2) const HomeButton(),
        ],
      ),
    );
  }
}
