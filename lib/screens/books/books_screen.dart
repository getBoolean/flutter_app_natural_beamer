import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/data/books.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_app_natural_beamer/locations/beam_locations.dart';

class BooksScreen extends StatelessWidget {
  BooksScreen({this.beamerKey});

  final GlobalKey<BeamerState> beamerKey;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
        leading: IconButton(
          alignment: Alignment.center,
          icon: Icon(Icons.settings),
          onPressed: () {
            beamerKey.currentState.routerDelegate
            .beamTo(beamLocations[2]);
          }
        ),
      ),
      body: ListView(
        children: books
            .map((book) => ListTile(
          title: Text(book['title']),
          subtitle: Text(book['author']),
          onTap: () => context.currentBeamLocation.update(
                (state) => state.copyWith(
              pathBlueprintSegments: ['books', ':bookId'],
              pathParameters: {'bookId': book['id']},
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}