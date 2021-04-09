import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_app_natural_beamer/data/clubs.dart';

class ClubsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Clubs")),
        body: ListView(
          children: clubs.map((room) => ListTile(
            title: Text(room['title']),
            subtitle: Text(room['description']),
            onTap: () => context.currentBeamLocation.update(
                    (state) => state.copyWith(
                  pathBlueprintSegments: ['settings', ':settingId'],
                  pathParameters: {'settingId': room['id']},
                )
            ),
          )).toList(),
        )
    );
  }
}