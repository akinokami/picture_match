import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picture_match/controller/game_option_controller.dart';
import 'package:picture_match/utils/constants.dart';
import 'package:picture_match/views/widgets/game_confetti.dart';
import 'package:picture_match/views/widgets/game_controls_bottomsheet.dart';
import 'package:picture_match/views/widgets/memory_card.dart';
import 'package:picture_match/views/widgets/mobile/game_best_time_mobile.dart';
import 'package:picture_match/views/widgets/mobile/game_timer_mobile.dart';
import 'package:picture_match/views/widgets/restart_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/game.dart';

class GameBoardMobile extends StatefulWidget {
  const GameBoardMobile({
    required this.gameLevel,
    required this.gameType,
    super.key,
  });

  final int gameLevel;
  final String gameType;

  @override
  State<GameBoardMobile> createState() => _GameBoardMobileState();
}

class _GameBoardMobileState extends State<GameBoardMobile> {
  final gameOptionController = Get.put(GameOptionController());
  late Timer timer;
  late Game game;
  late Duration duration;
  int bestTime = 0;
  bool showConfetti = false;
  //final box = GetStorage();

  @override
  void initState() {
    super.initState();
    game = Game(widget.gameLevel);
    duration = const Duration();
    startTimer();
    getBestTime();
  }

  void getBestTime() async {
    //todo
    // SharedPreferences gameSP = await SharedPreferences.getInstance();
    // if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') != null) {
    //   bestTime = gameSP.getInt('${widget.gameLevel.toString()}BestTime')!;
    // }
    if (widget.gameType == GameType.easy.name) {
      var easy = gameOptionController.gameEasyLevels
          .where((e) => e.level == widget.gameLevel)
          .firstOrNull;
      bestTime = easy?.bestTime ?? 0;
    }
    if (widget.gameType == GameType.normal.name) {
      var normal = gameOptionController.gameNormalLevels
          .where((e) => e.level == widget.gameLevel)
          .firstOrNull;
      bestTime = normal?.bestTime ?? 0;
    }
    if (widget.gameType == GameType.hard.name) {
      var hard = gameOptionController.gameHardLevels
          .where((e) => e.level == widget.gameLevel)
          .firstOrNull;
      bestTime = hard?.bestTime ?? 0;
    }

    print("bestTime>>>$bestTime");
    setState(() {});
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      setState(() {
        final seconds = duration.inSeconds + 1;
        duration = Duration(seconds: seconds);
      });
      //todo
      if (game.isGameOver) {
        timer.cancel();
        // SharedPreferences gameSP = await SharedPreferences.getInstance();
        // if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') == null ||
        //     gameSP.getInt('${widget.gameLevel.toString()}BestTime')! >
        //         duration.inSeconds) {
        //   gameSP.setInt(
        //       '${widget.gameLevel.toString()}BestTime', duration.inSeconds);
        //   setState(() {
        //     showConfetti = true;
        //     bestTime = duration.inSeconds;
        //   });
        // }

        if (widget.gameType == GameType.easy.name) {
          var e = gameOptionController.gameEasyLevels
              .where((e) => e.level == widget.gameLevel)
              .firstOrNull;
          if (e?.bestTime == 0 || (e?.bestTime ?? 0) > duration.inSeconds) {
            gameOptionController.setGameEasy(
                gameLevel: widget.gameLevel, duration: duration.inSeconds);
            setState(() {
              showConfetti = true;
              bestTime = duration.inSeconds;
            });
          }
        }
        if (widget.gameType == GameType.normal.name) {
          var e = gameOptionController.gameNormalLevels
              .where((e) => e.level == widget.gameLevel)
              .firstOrNull;
          if (e?.bestTime == 0 || (e?.bestTime ?? 0) > duration.inSeconds) {
            gameOptionController.setGameNormal(
                gameLevel: widget.gameLevel, duration: duration.inSeconds);
            setState(() {
              showConfetti = true;
              bestTime = duration.inSeconds;
            });
          }
        }
        if (widget.gameType == GameType.hard.name) {
          var e = gameOptionController.gameEasyLevels
              .where((e) => e.level == widget.gameLevel)
              .firstOrNull;
          if (e?.bestTime == 0 || (e?.bestTime ?? 0) > duration.inSeconds) {
            gameOptionController.setGameHard(
                gameLevel: widget.gameLevel, duration: duration.inSeconds);
            setState(() {
              showConfetti = true;
              bestTime = duration.inSeconds;
            });
          }
        }
      }
    });
  }

  pauseTimer() {
    timer.cancel();
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      timer.cancel();
      duration = const Duration();
      startTimer();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              RestartGame(
                isGameOver: game.isGameOver,
                pauseGame: () => pauseTimer(),
                restartGame: () => _resetGame(),
                continueGame: () => startTimer(),
                color: Colors.amberAccent[700]!,
              ),
              GameTimerMobile(
                time: duration,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: game.gridSize,
                  childAspectRatio: aspectRatio * 2,
                  children: List.generate(game.cards.length, (index) {
                    return MemoryCard(
                      index: index,
                      card: game.cards[index],
                      onCardPressed: game.onCardPressed,
                    );
                  }),
                ),
              ),
              GameBestTimeMobile(
                bestTime: bestTime,
              ),
            ],
          ),
          showConfetti ? const GameConfetti() : const SizedBox(),
        ],
      ),
    );
  }
}
