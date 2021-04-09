import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/data/settings.dart';
import 'package:beamer/beamer.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: settings.map((setting) => ListTile(
          title: Text(setting['title']),
          subtitle: Text(setting['description']),
          onTap: () => context.currentBeamLocation.update(
              (state) => state.copyWith(
                pathBlueprintSegments: ['settings', ':settingId'],
                pathParameters: {'settingId': setting['id']},
              )
          ),
        )).toList(),
      )
    );
  }
}