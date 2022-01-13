import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterdicerollapp/DiceRollView.dart';
import 'package:flutterdicerollapp/levels.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Levels(),
    );
  }
}
