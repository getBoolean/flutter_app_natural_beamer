import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/screens/clubs/clubs_screen.dart';

class MessagesLocation extends BeamLocation {
  MessagesLocation(BeamState state) : super(state)

  @override
  List<String> get pathBlueprints => ['/messages/:roomID'];

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
          roodId: state.pathParameters['clubID']
        ),
      ),
  ];
}