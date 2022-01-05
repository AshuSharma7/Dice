import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutterdicerollapp/DiceRollViewModel.dart';
import 'package:provider/provider.dart';

class DiceRollView extends StatefulWidget {
  DiceRollView();

  @override
  _DiceRollViewState createState() => _DiceRollViewState();
}

class _DiceRollViewState extends State<DiceRollView> {
  Map<int, Vector3> _diceRolls = {
    5: Vector3(0, 0, 0),
    6: Vector3(90, 0, 0),
    2: Vector3(180, 0, 0),
    1: Vector3(270, 0, 0),
    3: Vector3(0, 90, 0),
    4: Vector3(0, 270, 0),
  };

  int n = 5;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiceRollViewModel(),
      child: Consumer<DiceRollViewModel>(
        builder: (context, model, widget) {
          return Scaffold(
              backgroundColor: Color(0xFF233254),
              body: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Spacer(),
                  Image.asset(
                    'images/' + "dice_${model.diceNumber}.png",
                    height: 150,
                    width: 150,
                  ),
                  Container(
                    height: 500,
                    width: 500,
                    child: Cube(
                      onSceneCreated: (Scene scene) {
                        scene.world.add(Object(
                            fileName: 'assets/Dice.obj',
                            name: "cube",
                            rotation: _diceRolls[n],
                            scale: Vector3.all(3)));
                      },
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        n = Random().nextInt(6) + 1;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Color(0xFF))],
                          color: Color(0xFF2a4262),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                        child: Text(
                          'Roll Dice',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
