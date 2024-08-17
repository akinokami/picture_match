import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picture_match/utils/app_theme.dart';

Constants constants = Constants();

class Constants {
  static final Constants _constants = Constants._i();

  factory Constants() {
    return _constants;
  }

  Constants._i();
  void showSnackBar(
      {String? title, String? msg, Color? bgColor, Color? textColor}) {
    Get.snackbar(
      title ?? "",
      msg ?? "",
      colorText: textColor ?? AppTheme.blackTextColor,
      backgroundColor: bgColor ?? AppTheme.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}

const Color continueButtonColor = Color.fromRGBO(32, 191, 235, 1);
const Color restartButtonColor = Color.fromRGBO(243, 181, 45, 1);
Color quitButtonColor = Colors.green; //Color.fromRGBO(39, 162, 149, 1);

List<Map<String, dynamic>> gameEasyLevels = [
  {'title': '3 x 4', 'level': 3, 'color': Colors.greenAccent, 'name': '1'},
  {'title': '4 x 4', 'level': 4, 'color': Colors.greenAccent, 'name': '2'},
  {'title': '5 x 6', 'level': 5, 'color': Colors.greenAccent, 'name': '3'},
  {'title': '6 x 6', 'level': 6, 'color': Colors.greenAccent, 'name': '4'},
  {'title': '7 x 8', 'level': 7, 'color': Colors.greenAccent, 'name': '5'},
  {'title': '8 x 8', 'level': 8, 'color': Colors.greenAccent, 'name': '6'},
  {'title': '9 x 10', 'level': 9, 'color': Colors.greenAccent, 'name': '7'},
];

//const String gameTitle = 'MEMORY MATCH';

enum GameType { easy, normal, hard }

// List<Map<String, dynamic>> easyList = [
//   {"level": 1, "playable": true, "bestTime": 0},
//   {"level": 2, "playable": false, "bestTime": 0},
//   {"level": 3, "playable": false, "bestTime": 0},
//   {"level": 4, "playable": false, "bestTime": 0},
//   {"level": 5, "playable": false, "bestTime": 0},
//   {"level": 6, "playable": false, "bestTime": 0},
//   {"level": 7, "playable": false, "bestTime": 0},
// ];
