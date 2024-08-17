import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picture_match/controller/game_option_controller.dart';
import 'package:picture_match/models/game.dart';
import 'package:picture_match/utils/constants.dart';
import 'package:picture_match/views/widgets/game_button.dart';
import '../../utils/app_theme.dart';
import '../screens/game/memory_match_page.dart';

class GameOptions extends StatelessWidget {
  final String gameType;
  const GameOptions({super.key, required this.gameType});

  static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel) {
    return MaterialPageRoute(
      builder: (_) {
        return MemoryMatchPage(gameLevel: gameLevel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameOptionController = Get.put(GameOptionController());
    if (gameType == GameType.easy.name) {
      return Obx(
        () => ListView.builder(
            shrinkWrap: true,
            itemCount: gameOptionController.gameEasyLevels.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GameButton(
                  onPressed:
                      gameOptionController.gameEasyLevels[index].playable ==
                              true
                          ? () => Navigator.of(context).push(
                                _routeBuilder(
                                    context,
                                    gameOptionController
                                            .gameEasyLevels[index].level ??
                                        1),
                              )
                          : null, //  (Route<dynamic> route) => false
                  title:
                      "${'level'.tr} ${gameOptionController.gameEasyLevels[index].name}",
                  color: AppTheme.green,
                  width: 250,
                ),
              );
            }),
      );
    } else if (gameType == GameType.normal.name) {
      return Obx(
        () => ListView.builder(
            shrinkWrap: true,
            itemCount: gameOptionController.gameNormalLevels.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GameButton(
                  onPressed:
                      gameOptionController.gameNormalLevels[index].playable ==
                              true
                          ? () => Navigator.of(context).push(
                                _routeBuilder(
                                    context,
                                    gameOptionController
                                            .gameEasyLevels[index].level ??
                                        1),
                              )
                          : null, //  (Route<dynamic> route) => false
                  title:
                      "${'level'.tr} ${gameOptionController.gameNormalLevels[index].name}",
                  color: AppTheme.green,
                  width: 250,
                ),
              );
            }),
      );
    } else {
      return Obx(
        () => ListView.builder(
            shrinkWrap: true,
            itemCount: gameOptionController.gameHardLevels.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GameButton(
                  onPressed:
                      gameOptionController.gameHardLevels[index].playable ==
                              true
                          ? () => Navigator.of(context).push(
                                _routeBuilder(
                                    context,
                                    gameOptionController
                                            .gameHardLevels[index].level ??
                                        1),
                              )
                          : null, //  (Route<dynamic> route) => false
                  title:
                      "${'level'.tr} ${gameOptionController.gameHardLevels[index].name}",
                  color: AppTheme.green,
                  width: 250,
                ),
              );
            }),
      );
    }
    // return Column(
    //   children: gameLevels.map((level) {
    //     return Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: GameButton(
    //         onPressed: () => Navigator.of(context).push(
    //           _routeBuilder(context, level['level']),
    //         ), //  (Route<dynamic> route) => false
    //         title: "${'level'.tr} ${level['name']}",
    //         color: AppTheme.greyTicket,
    //         width: 250,
    //       ),
    //     );
    //   }).toList(),
    // );
  }
}
