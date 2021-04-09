import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/widgets/dark_mode_switch.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Light Mode"),
                DarkModeSwitch(),
                Text("Dark Mode"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}