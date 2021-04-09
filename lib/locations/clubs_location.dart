import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/screens/clubs/clubs_screen.dart';
import 'package:flutter_app_natural_beamer/screens/clubs/club_room_screen.dart';

class ClubsLocation extends BeamLocation {
  ClubsLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/clubs/:clubID'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: ValueKey('clubs'),
      child: ClubsScreen(),
    ),
    if (state.pathParameters.containsKey('clubID'))
      BeamPage(
        key: ValueKey('clubs-${state.pathParameters['clubID']}'),
        child: ClubRoomScreen(
          clubId: state.pathParameters['clubID']
        ),
      ),
  ];
}