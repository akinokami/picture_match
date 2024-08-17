import 'dart:convert';

import 'package:get/get.dart';
import 'package:picture_match/utils/constants.dart';

import '../models/game_level.dart';

class GameOptionController extends GetxController {
  RxList<GameLevel> gameEasyLevels = <GameLevel>[].obs;
  RxList<GameLevel> gameNormalLevels = <GameLevel>[].obs;
  RxList<GameLevel> gameHardLevels = <GameLevel>[].obs;

  @override
  void onInit() {
    getGameEasy();
    getGameNormal();
    getGameHard();
    super.onInit();
  }

//box.write('carts', jsonEncode(selectedChannelList.map((item) => item.toJson()).toList()));
  void getGameEasy() {
    List<dynamic> list = jsonDecode(gameLevels);
    gameEasyLevels.value =
        list.map((json) => GameLevel.fromJson(json)).toList();
  }

  void getGameNormal() {
    List<dynamic> list = jsonDecode(gameLevels);
    gameNormalLevels.value =
        list.map((json) => GameLevel.fromJson(json)).toList();
  }

  void getGameHard() {
    List<dynamic> list = jsonDecode(gameLevels);
    gameHardLevels.value =
        list.map((json) => GameLevel.fromJson(json)).toList();
  }
}
