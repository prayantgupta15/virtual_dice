import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shake/shake.dart';
import 'package:virtualdice/dice_brain.dart';

class OneDiceGame extends StatefulWidget {
  @override
  _OneDiceGameState createState() => _OneDiceGameState();
}

class _OneDiceGameState extends State<OneDiceGame> {
  int left = Random().nextInt(6) + 1;
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
        print("$i left: $left ");
      });
    }
    canTap = true;
    Fluttertoast.showToast(
      msg: "Got $left",
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  void initState() {
    detector = ShakeDetector.waitForStart(
      onPhoneShake: () {
        print("shkaing");
//      Fluttertoast.showToast(
//          msg: "Device Shaking", toastLength: Toast.LENGTH_SHORT);
        diceplay();
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    canTap
        ? diceBrain.getShakeSetting()
            ? detector.startListening()
            : detector.stopListening()
        : null;

    return Stack(
      children: <Widget>[
        Container(
            color: Colors.white,
            height: screenHeight,
            width: screenWidth,
            child: Image(
                image: new NetworkImage(
                    'https://media1.tenor.com/images/2fcf7e0bdb5ed04fcb5092cf2479907e/tenor.gif?itemid=4717877'))),
        Center(
          child: Shimmer.fromColors(
            baseColor: diceBrain.diceAccentColor(left),
            highlightColor: diceBrain.diceColor(left),
            child: Container(
              height: screenHeight / 1.5,
              width: screenWidth / 1.5,
              child: FlatButton(
                child: Image.asset('images/dice$left.png'),
                onPressed:
                    diceBrain.getTapSetting() ? canTap ? diceplay : null : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
