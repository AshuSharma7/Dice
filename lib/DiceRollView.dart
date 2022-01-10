import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutterdicerollapp/DiceRollViewModel.dart';
import 'package:provider/provider.dart';

class DiceRollView extends StatefulWidget {
  DiceRollView();

  @override
  _DiceRollViewState createState() => _DiceRollViewState();
}

class _DiceRollViewState extends State<DiceRollView>
    with TickerProviderStateMixin {
  AnimationController controller;

  Map<int, Vector3> _diceRolls = {
    5: Vector3(0, 0, 0),
    6: Vector3(90, 0, 0),
    2: Vector3(180, 0, 0),
    1: Vector3(270, 0, 0),
    3: Vector3(0, 90, 0),
    4: Vector3(0, 270, 0),
  };
  Object dice;
  Animation<Vector3> roll;
  Vector3 lastRoll = Vector3(0, 0, 0);

  int n = 5;

  AudioCache _audioCache;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    dice = Object(fileName: "assets/Dice.obj", scale: Vector3.all(3.0));
    controller.addListener(() {
      dice.rotation.setFrom(roll.value);
      dice.updateTransform();
      setState(() {});
    });
    super.initState();
    _audioCache = AudioCache(
      prefix: 'assets/audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
  }

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
                  Container(
                    height: 500,
                    width: 500,
                    child: Cube(
                      onSceneCreated: (Scene scene) {
                        scene.world.add(dice);
                      },
                    ),
                  ),
                  Spacer(),
                  if (controller.isCompleted)
                    Text(
                      "You got $n",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      n = Random().nextInt(6) + 1;
                      if (n == 6) {
                        n = Random().nextInt(6) + 1;
                        if (n == 6) {
                          n = Random().nextInt(6) + 1;
                        }
                      } else if (n == 5 || n == 4) {
                        n = Random().nextInt(6) + 1;
                      }
                      _audioCache.play('roll.mp3');
                      print(n);
                      var temp = Random().nextInt(360);
                      roll = Tween<Vector3>(
                              begin: lastRoll, end: Vector3.all(temp + 0.0))
                          .animate(CurvedAnimation(
                              parent: controller, curve: Curves.linear));
                      controller.reset();
                      await controller.forward();
                      roll = Tween<Vector3>(
                              begin: Vector3.all(temp + 0.0),
                              end: _diceRolls[n])
                          .animate(CurvedAnimation(
                              parent: controller, curve: Curves.easeIn));
                      lastRoll = _diceRolls[n];
                      controller.reset();
                      controller.forward();
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
