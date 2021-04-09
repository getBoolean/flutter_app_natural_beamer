import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_app_natural_beamer/provider.dart';
import 'package:flutter_app_natural_beamer/screens/home.dart';
import 'package:flutter_app_natural_beamer/screens/settings.dart';
import 'package:flutter_app_natural_beamer/models/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final darkModeEnabled = useProvider(appThemeStateNotifier);
    return MaterialApp.router(
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: BeamerRouterDelegate(
          locationBuilder: SimpleLocationBuilder(
              routes: {
                '/': (context) => MyHomePage(),
                '/settings': (context) => Settings(),
              }
          )
      ),
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
    );
  }
}