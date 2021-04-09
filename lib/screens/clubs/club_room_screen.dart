import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/data/clubs.dart';

class ClubRoomScreen extends StatelessWidget {
  ClubRoomScreen({
    this.clubId,
  }) : club = clubs.firstWhere((club) => club['id'] == clubId);

  final String clubId;
  final Map<String, String> club;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${club['title']}')),
      body: Text('${club['subtitle']}'),
    );
  }
}