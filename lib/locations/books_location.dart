import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/screens/books/book_details_screen.dart';
import 'package:flutter_app_natural_beamer/screens/books/books_screen.dart';

class BooksLocation extends BeamLocation {
  BooksLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/books/:bookId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: ValueKey('books'),
      child: BooksScreen(),
    ),
    if (state.pathParameters.containsKey('bookId'))
      BeamPage(
        key: ValueKey('book-${state.pathParameters['bookId']}'),
        child: BookDetailsScreen(
          bookId: state.pathParameters['bookId'],
        ),
      ),
  ];
}