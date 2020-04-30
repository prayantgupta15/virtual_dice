import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shake/shake.dart';
import 'package:shimmer/shimmer.dart';

import 'dice_brain.dart';

class TwoDiceGame extends StatefulWidget {
  @override
  _TwoDiceGameState createState() => _TwoDiceGameState();
}

class _TwoDiceGameState extends State<TwoDiceGame> {
  int left = Random().nextInt(6) + 1, right = Random().nextInt(6) + 1;
  bool canTap = true;
  ShakeDetector detector;
  DiceBrain diceBrain = DiceBrain();

  void diceplay() async {
    AudioCache ac = AudioCache();
    diceBrain.canPlaySound() ? ac.play('dice.mp3') : null;
    diceBrain.canPlayGoldSound() ? ac.play('gold.wav', volume: 0.5) : null;
    HapticFeedback.vibrate();
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        canTap = false;
        left = diceBrain.changeLeftDiceNumber();
        right = diceBrain.changeRightDiceNumber();
        print("$i left: $left ,right: $right");
      });
    }
    canTap = true;
    Fluttertoast.showToast(
      msg: "Got $left , $right",
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  void initState() {
    detector = ShakeDetector.autoStart(onPhoneShake: () {
//      Fluttertoast.showToast(msg: "Device Shaking");
      print("shkaing");
      diceplay();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("canTap $canTap");
    canTap
        ? diceBrain.getShakeSetting()
            ? detector.startListening()
            : detector.stopListening()
        : null;
    Size size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: screenHeight,
          width: screenWidth,
          child: Image(
              image: new NetworkImage(
                  'https://media1.tenor.com/images/2fcf7e0bdb5ed04fcb5092cf2479907e/tenor.gif?itemid=4717877')),

//            child: Image(
//              image: AssetImage('images/wood.jpg'),
//              fit: BoxFit.fitHeight,
//            )
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: diceBrain.diceAccentColor(left),
                    highlightColor: diceBrain.diceColor(left),
                    child: FlatButton(
                      child: Image.asset('images/dice$left.png'),
                      onPressed: diceBrain.getTapSetting()
                          ? canTap ? diceplay : null
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: diceBrain.diceAccentColor(right),
                    highlightColor: diceBrain.diceColor(right),
                    child: FlatButton(
                      child: Image.asset('images/dice$right.png'),
                      onPressed: diceBrain.getTapSetting()
                          ? canTap ? diceplay : null
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
