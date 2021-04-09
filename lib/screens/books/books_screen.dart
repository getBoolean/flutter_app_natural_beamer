import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/data/books.dart';
import 'package:beamer/beamer.dart';

class BooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
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