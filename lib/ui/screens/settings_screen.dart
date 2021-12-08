import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:places/data/redux/action/theme_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/theme_state.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;

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
                StoreConnector<AppState, ThemeState>(
                  converter: (store) {
                    return store.state.themeState;
                  },
                  builder: (BuildContext context, ThemeState vm) {
                    debugPrint('Draw FlutterSwitch! ' + vm.themeStatus.toString());
                    return FlutterSwitch(
                      height: 32.0,
                      width: 56.0,
                      padding: 2.0,
                      toggleSize: 28.0,
                      borderRadius: 16.0,
                      inactiveColor: myInactiveBlack.withOpacity(0.56),
                      activeColor: myDarkGreen,
                      value: vm.themeStatus,
                      onToggle: (value) {
                        debugPrint('onToggle!' + vm.themeStatus.toString());

                        StoreProvider.of<AppState>(context)
                            .dispatch(ToggleThemeAction());
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
