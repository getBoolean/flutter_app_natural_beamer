import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/data/settings.dart';

class SettingDetailsScreen extends StatelessWidget {
  SettingDetailsScreen({
    this.settingId,
  }) : setting = settings.firstWhere((book) => book['id'] == settingId);

  final String settingId;
  final Map<String, String> setting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${setting['title']}')),
      body: Center(child: Text('${setting['description']}')),
    );
  }
}