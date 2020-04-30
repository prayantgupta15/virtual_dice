import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:virtualdice/twodicegame.dart';

import 'OneDiceGame.dart';
import 'dice_brain.dart';

void main() {
  return runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  DiceBrain diceBrain = DiceBrain();

  bool playingwith2 = false;
  @override
  Widget build(BuildContext context) {
    diceBrain.playWith1();
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
//        backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 4,
//          leading: Icon(
//            MdiIcons.diceMultiple,
//            color: Colors.white,
//            size: 40,
//          ),
            actions: <Widget>[Icon(Icons.share)],
            title: Text(
              'Virtual Dice',
              style: TextStyle(color: Colors.white),
            ),
//          centerTitle: true,
//          backgroundColor: Colors.black,
          ),
          drawer: Drawer(
            elevation: 50,
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(),
                ListTile(
                  leading: playingwith2
                      ? Icon(
                          MdiIcons.dice1Outline,
                          size: 40,
                        )
                      : Icon(
                          MdiIcons.diceMultiple,
                          size: 40,
                        ),
                  title: playingwith2
                      ? Text("Play with 1 Die")
                      : Text("Play with 2 Dice"),
                  onTap: () {
                    HapticFeedback.vibrate();
                    setState(() {
                      playingwith2
                          ? diceBrain.playWith2()
                          : diceBrain.playWith1();
                      playingwith2 = !playingwith2;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text("Dice Roll Sound"),
                  trailing: Switch(
                    value: diceBrain.canPlaySound(),
                    onChanged: (value) {
                      setState(() {
                        HapticFeedback.vibrate();
                        diceBrain.changeSound();
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: Color(0xffFFDF00),
                  ),
                  title: Text(
                    "Gold Coin Sound",
                    style: TextStyle(color: Color(0xffFFDF00)),
                  ),
                  trailing: Switch(
                    value: diceBrain.canPlayGoldSound(),
                    onChanged: (value1) {
                      HapticFeedback.vibrate();
                      setState(() {
                        diceBrain.changeGoldSound();
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.vibration,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Shake to Roll",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Switch(
                    value: diceBrain.getShakeSetting(),
                    onChanged: (value1) {
                      HapticFeedback.vibrate();
                      setState(() {
                        diceBrain.changeShakeSetting();
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.touch_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Tap to Roll",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Switch(
                    value: diceBrain.getTapSetting(),
                    onChanged: (value1) {
                      HapticFeedback.vibrate();
                      setState(() {
                        diceBrain.changeTapSetting();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          body: playingwith2 ? TwoDiceGame() : OneDiceGame(),
        ),
      ),
    );
  }
}
