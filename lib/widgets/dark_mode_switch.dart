import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkModeEnabled = context.read(appThemeStateNotifier);
    return Switch(
      value: darkModeEnabled,
      onChanged: (enabled) {
        if (enabled) {
          context.read(appThemeStateNotifier.notifier).setDarkTheme();
        } else {
          context.read(appThemeStateNotifier.notifier).setLightTheme();
        }
      },
    );
  }
}