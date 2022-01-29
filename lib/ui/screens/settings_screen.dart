import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:places/data/cubits/theme/theme_cubit.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/screens/onboarding_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: const _AppBarSettings(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    constants.textDarkTheme,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return FlutterSwitch(
                      height: 32.0,
                      width: 56.0,
                      padding: 2.0,
                      toggleSize: 28.0,
                      borderRadius: 16.0,
                      inactiveColor: myInactiveBlack.withOpacity(0.56),
                      activeColor: myDarkGreen,
                      value: state.themeStatus,
                      onToggle: (value) {
                        BlocProvider.of<ThemeCubit>(context).switchTheme();
                      },
                    );
                  },
                ),
              ],
            ),
            Divider(color: myLightSecondaryTwo.withOpacity(0.56)),
            const SizedBox(height: 3),
            Row(
              children: [
                Expanded(
                  child: Text(
                    constants.textBtnTutorial,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const OnboardingScreen(fromSettings: true),
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).colorScheme.primaryVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Divider(color: myLightSecondaryTwo.withOpacity(0.56)),
          ],
        ),
      ),
    );
  }
}

class _AppBarSettings extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  const _AppBarSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          constants.textSettings,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}
