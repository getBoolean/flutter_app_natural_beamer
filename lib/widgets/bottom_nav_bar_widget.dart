import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/locations/beam_locations.dart';
import 'package:flutter_app_natural_beamer/locations/books_location.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget({this.beamerKey});

  final GlobalKey<BeamerState> beamerKey;

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  @override
  void initState() {
    widget.beamerKey.currentState.routerDelegate
        .addListener(() => _updateCurrentIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(label: 'Books', icon: Icon(Icons.book)),
        BottomNavigationBarItem(label: 'Clubs', icon: Icon(Icons.message)),
      ],
      onTap: (index) {
        widget.beamerKey.currentState.routerDelegate
            .beamTo(beamLocations[index]);
      }
    );
  }

  void _updateCurrentIndex() {
    final index =
        (widget.beamerKey.currentState.currentLocation is BooksLocation)
            ? 0
            : 1;
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
    }
  }
}