import 'package:beamer/beamer.dart';
import 'package:flutter_app_natural_beamer/locations/books_location.dart';
import 'package:flutter_app_natural_beamer/locations/clubs_location.dart';
import 'package:flutter_app_natural_beamer/locations/settings_location.dart';

final beamLocations = [
  BooksLocation(BeamState()),
  ClubsLocation(BeamState()),
  SettingsLocation(BeamState()),
];