import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/screens/settings/setting_details_screen.dart';
import 'package:flutter_app_natural_beamer/screens/settings/settings_screen.dart';

class SettingsLocation extends BeamLocation {
  SettingsLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/settings/:id'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: ValueKey('settings'),
      child: SettingsScreen(),
    ),
    if (state.pathParameters.containsKey('id'))
      BeamPage(
        key: ValueKey('settings-${state.pathParameters['id']}'),
        child: SettingDetailsScreen(
            settingId: state.pathParameters['id']
        ),
      ),
  ];
}