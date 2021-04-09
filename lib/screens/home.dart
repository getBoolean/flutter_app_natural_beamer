import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_natural_beamer/widgets/dark_mode_switch.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Flutter Theme Riverpod Demo"),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Beamer.of(context).beamToNamed('/settings');
                },
              )
            ],
          )

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