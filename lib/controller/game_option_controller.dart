import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picture_match/utils/constants.dart';

import '../models/game_level.dart';

class GameOptionController extends GetxController {
  final box = GetStorage();
  RxList<GameLevel> gameEasyLevels = <GameLevel>[].obs;
  RxList<GameLevel> gameNormalLevels = <GameLevel>[].obs;
  RxList<GameLevel> gameHardLevels = <GameLevel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    getGameEasy();
    getGameNormal();
    getGameHard();
    super.onInit();
  }

  ///EASY
  void getGameEasy() async {
    var easyData = await box.read(GameType.easy.name);
    if (easyData == null) {
      List<dynamic> list = jsonDecode(easyLevels);
      gameEasyLevels.value =
          list.map((json) => GameLevel.fromJson(json)).toList();
      await box.write(GameType.easy.name,
          jsonEncode(gameEasyLevels.map((item) => item.toJson()).toList()));
    } else {
      List<dynamic> list = jsonDecode(easyData);
      gameEasyLevels.value =
          list.map((json) => GameLevel.fromJson(json)).toList();
    }
  }

  void setGameEasy({required int gameLevel, required int duration}) async {
    isLoading.value = true;
    for (int i = 0; i < gameEasyLevels.length; i++) {
      if (gameEasyLevels[i].level == gameLevel) {
        gameEasyLevels[i].bestTime = duration;
        if (i + 1 < gameEasyLevels.length) {
          gameEasyLevels[i + 1].playable = true;
        }
      }
    }
    await box.write(GameType.easy.name,
        jsonEncode(gameEasyLevels.map((item) => item.toJson()).toList()));
    isLoading.value = false;
  }

  ///NORMAL
  void getGameNormal() async {
    var normalData = await box.read(GameType.normal.name);
    if (normalData == null) {
      List<dynamic> list = jsonDecode(normalLevels);
      gameNormalLevels.value =
          list.map((json) => GameLevel.fromJson(json)).toList();
      await box.write(GameType.normal.name,
          jsonEncode(gameNormalLevels.map((item) => item.toJson()).toList()));
    } else {
      List<dynamic> list = jsonDecode(normalData);
      gameNormalLevels.value =
          list.map((json) => GameLevel.fromJson(json)).toList();
    }
  }

  void setGameNormal({required int gameLevel, required int duration}) async {
    isLoading.value = true;
    for (int i = 0; i < gameNormalLevels.length; i++) {
      if (gameNormalLevels[i].level == gameLevel) {
        gameNormalLevels[i].bestTime = duration;
        if (i + 1 < gameNormalLevels.length) {
          gameNormalLevels[i + 1].playable = true;
        }
      }
    }
    await box.write(GameType.normal.name,
        jsonEncode(gameNormalLevels.map((item) => item.toJson()).toList()));
    isLoading.value = false;
  }

  ///HARD
  void getGameHard() async {
    var hardData = await box.read(GameType.hard.name);
    if (hardData == null) {
      List<dynamic> list = jsonDecode(hardLevels);
      gameHardLevels.value =
          list.map((json) => GameLevel.fromJson(json)).toList();
      await box.write(GameType.hard.name,
          jsonEncode(gameHardLevels.map((item) => item.toJson()).toList()));
    } else {
      List<dynamic> list = jsonDecode(hardData);
      gameHardLevels.value =
          list.map((json) => GameLevel.fromJson(json)).toList();
    }
  }

  void setGameHard({required int gameLevel, required int duration}) async {
    isLoading.value = true;
    for (int i = 0; i < gameHardLevels.length; i++) {
      if (gameHardLevels[i].level == gameLevel) {
        gameHardLevels[i].bestTime = duration;
        if (i + 1 < gameHardLevels.length) {
          gameHardLevels[i + 1].playable = true;
        }
      }
    }
    await box.write(GameType.hard.name,
        jsonEncode(gameHardLevels.map((item) => item.toJson()).toList()));
    isLoading.value = false;
  }
}
