import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/locations/books_location.dart';
import 'package:flutter_app_natural_beamer/locations/clubs_location.dart';
import 'package:flutter_app_natural_beamer/locations/settings_location.dart';
import 'package:flutter_app_natural_beamer/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_app_natural_beamer/provider.dart';
import 'package:flutter_app_natural_beamer/models/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  final _beamerKey = GlobalKey<BeamerState>();

  @override
  Widget build(BuildContext context) {
    final darkModeEnabled = useProvider(appThemeStateNotifier);
    return MaterialApp.router(
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: RootRouterDelegate(
          homeBuilder: (context, uri) => Scaffold(
            body: Beamer(
              key: _beamerKey,
              routerDelegate: BeamerRouterDelegate(
                locationBuilder: (state) {
                  if (state.uri.pathSegments.contains('books')) {
                    return BooksLocation(state);
                  }
                  return ClubsLocation(state);
                }
              ),
            ),
            bottomNavigationBar: BottomNavigationBarWidget(
              beamerKey: _beamerKey,
            ),
          )
      ),
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
    );
  }
}