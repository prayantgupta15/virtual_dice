import 'dart:math';

import 'package:flutter/material.dart';

class DiceBrain {
  static int _numberOfDice = 1;
  static int _leftDiceNumber, _rightDiceNumber;
  static bool _canPlaySound = true;
  static bool _canPlayGoldSound = true;
  static bool _tapToRoll = true, _shakeToRoll = false;

  void changeShakeSetting() {
    _shakeToRoll = !_shakeToRoll;
    print(_shakeToRoll);
  }

  void changeTapSetting() {
    _tapToRoll = !_tapToRoll;
  }

  bool getShakeSetting() {
    return _shakeToRoll;
  }

  bool getTapSetting() {
    return _tapToRoll;
  }

  void changeSound() {
    _canPlaySound = !_canPlaySound;
  }

  void changeGoldSound() {
    _canPlayGoldSound = !_canPlayGoldSound;
  }

  bool canPlaySound() {
    return _canPlaySound;
  }

  bool canPlayGoldSound() {
    return _canPlayGoldSound;
  }

  void playWith2() {
    _numberOfDice = 2;
  }

  void playWith1() {
    _numberOfDice = 1;
  }

  int getNumberOfDice() {
    return _numberOfDice;
  }

  int changeLeftDiceNumber() {
    _leftDiceNumber = Random().nextInt(6) + 1;
    return _leftDiceNumber;
  }

  int changeRightDiceNumber() {
    _rightDiceNumber = Random().nextInt(6) + 1;
    return _rightDiceNumber;
  }

  Color diceAccentColor(int n) {
    Color a = Color(0xffFFDF00);
    return a;
  }

  Color diceColor(int number) {
    return Color(0xffD4AF37);
  }

//  MaterialColor diceColor(int number) {
//    return number == 1
//        ? Colors.red
//        : number == 2
//            ? Colors.blue
//            : number == 3
//                ? Colors.yellow
//                : number == 4
//                    ? Colors.green
//                    : number == 5
//                        ? Colors.purple
//                        : number == 6 ? Colors.pink : Colors.black;
//  }

//  MaterialAccentColor diceAccentColor(int number) {
//    return number == 1
//        ? Colors.redAccent
//        : number == 2
//            ? Colors.blueAccent
//            : number == 3
//                ? Colors.yellowAccent
//                : number == 4
//                    ? Colors.greenAccent
//                    : number == 5
//                        ? Colors.purpleAccent
//                        : number == 6 ? Colors.pinkAccent : Colors.black;
//  }
}
