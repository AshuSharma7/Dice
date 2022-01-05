import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiceRollViewModel extends ChangeNotifier {
  int _diceNumber = 1;

  int get diceNumber => _diceNumber;

  set changeDice(int value) {
    _diceNumber = value;
  }

  void rollDice() {
    changeDice = Random().nextInt(6) + 1;
    notifyListeners();
  }
}
