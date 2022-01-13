import 'package:flutter/material.dart';
import 'package:flutterdicerollapp/DiceRollView.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';

class Levels extends StatefulWidget {
  const Levels({Key key}) : super(key: key);

  @override
  _LevelsState createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  List<PointModel> points = [];

  fill() {
    for (int i = 0; i < 10; i++) {
      PointModel point = PointModel(100, pointer(i));

      points.add(point);
    }
  }

  Widget pointer(int i) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: DiceRollView())),
              );
            });
      },
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/map_horizontal_point.png"))),
          child: Center(child: Text("${i + 1}"))),
    );
  }

  @override
  void initState() {
    fill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.green])),
              child: GameLevelsScrollingMap.scrollable(
                "assets/bg.webp",
                points: points,
                direction: Axis.vertical,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                x_values: [450, 350, 480, 550, 520, 420, 300, 350, 415, 400],
                y_values: [
                  480,
                  600,
                  720,
                  840,
                  1000,
                  1150,
                  1300,
                  1550,
                  1750,
                  1950
                ],
              )
              // ListView.builder(
              //   itemCount: 10,
              //   reverse: true,
              //   itemBuilder: (context, index) {
              //   return Align(
              //     alignment: index.isEven ? Alignment.centerLeft : Alignment.centerRight,
              //     child: Container(
              //       margin: EdgeInsets.all(50.0),
              //       width: 60.0,
              //       height: 60.0,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(image: AssetImage("images/medal.png")),
              //       ),
              //       padding: EdgeInsets.only(bottom: 8),
              //       child: Center(child: Text("${index+1}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),),
              //     ),
              //   );
              // }),
              )),
    );
  }
}
