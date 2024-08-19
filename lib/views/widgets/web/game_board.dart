import 'dart:async';
import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:picture_match/models/game.dart';
import 'package:picture_match/utils/app_theme.dart';
import 'package:picture_match/views/widgets/memory_card.dart';
import 'package:picture_match/views/widgets/restart_game.dart';
import 'package:picture_match/views/widgets/web/game_best_time.dart';
import 'package:picture_match/views/widgets/web/game_timer.dart';

import '../../../controller/game_option_controller.dart';
import '../../../utils/constants.dart';
import '../game_confetti.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    required this.gameLevel,
    required this.gameType,
    required this.limitTime,
    super.key,
  });

  final int gameLevel;
  final String gameType;
  final int limitTime;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final gameOptionController = Get.put(GameOptionController());
  Timer? timer;
  late Game game;
  late Duration duration;
  int bestTime = 0;
  bool showConfetti = false;
  final int t = 8;
  final CountDownController countDownController = CountDownController();
  bool isTimeCount = true;

  @override
  void initState() {
    super.initState();
    game = Game(widget.gameLevel);
    duration = const Duration();
    Future.delayed(Duration(seconds: t), () {
      game.setAllCardsHidden();
      startTimer();
      isTimeCount = false;
    });
    getBestTime();
  }

  // void getBestTime() async {
  //   SharedPreferences gameSP = await SharedPreferences.getInstance();
  //   if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') != null) {
  //     bestTime = gameSP.getInt('${widget.gameLevel.toString()}BestTime')!;
  //   }

  //   setState(() {});
  // }
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

    setState(() {});
  }

  // startTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (_) async {
  //     setState(() {
  //       final seconds = duration.inSeconds + 1;
  //       duration = Duration(seconds: seconds);
  //     });

  //     if (game.isGameOver) {
  //       timer.cancel();
  //       SharedPreferences gameSP = await SharedPreferences.getInstance();
  //       if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') == null ||
  //           gameSP.getInt('${widget.gameLevel.toString()}BestTime')! >
  //               duration.inSeconds) {
  //         gameSP.setInt(
  //             '${widget.gameLevel.toString()}BestTime', duration.inSeconds);
  //         setState(() {
  //           showConfetti = true;
  //           bestTime = duration.inSeconds;
  //         });
  //       }
  //     }
  //   });
  // }
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (mounted) {
        setState(() {
          final seconds = duration.inSeconds + 1;
          duration = Duration(seconds: seconds);
        });
      }
      if (widget.limitTime != 0) {
        if (duration.inSeconds >= widget.limitTime) {
          timer?.cancel();
          game.isGameOver = true;
          print("gameOver");
          constants.gameOverDialog(() {
            _resetGame();
            Navigator.pop(context);
          });
        }
      }

      //todo
      if (game.isGameFinish) {
        timer?.cancel();
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
    timer?.cancel();
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      isTimeCount = true;
      timer?.cancel();
      duration = const Duration();
      Future.delayed(Duration(seconds: t), () {
        game.setAllCardsHidden();
        startTimer();
        isTimeCount = false;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveSpacing = sqrt(MediaQuery.of(context).size.width) *
        sqrt(MediaQuery.of(context).size.height);

    return Stack(
      children: [
        GridView.count(
          padding: const EdgeInsets.fromLTRB(8.0, 80.0, 8.0, 8.0),
          childAspectRatio: MediaQuery.of(context).size.aspectRatio * 1.2,
          mainAxisSpacing: responsiveSpacing / 100,
          crossAxisSpacing: responsiveSpacing / 100,
          crossAxisCount: game.gridSize,
          children: List.generate(game.cards.length, (index) {
            return MemoryCard(
              index: index,
              card: game.cards[index],
              onCardPressed: game.onCardPressed,
            );
          }),
        ),
        Positioned(
          top: 12.0,
          right: 24.0,
          child: isTimeCount
              ? CircularCountDownTimer(
                  duration: t,
                  initialDuration: 0,
                  controller: countDownController,
                  height: 35.w,
                  width: 35.w,
                  ringColor: AppTheme.premiumColor2,
                  ringGradient: null,
                  fillColor: Colors.white,
                  fillGradient: null,
                  backgroundColor: AppTheme.green,
                  backgroundGradient: null,
                  strokeWidth: 4.w,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    debugPrint('Countdown Started');
                  },
                  onComplete: () {
                    debugPrint('Countdown Ended');
                    isTimeCount = false;
                  },
                  onChange: (String timeStamp) {
                    debugPrint('Countdown Changed $timeStamp');
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      return "0";
                    } else {
                      return Function.apply(
                          defaultFormatterFunction, [duration]);
                    }
                  },
                )
              : RestartGame(
                  isGameOver: game.isGameFinish,
                  pauseGame: () => pauseTimer(),
                  restartGame: () => _resetGame(),
                  continueGame: () => startTimer(),
                ),
        ),
        Positioned(
          bottom: 12.0,
          right: 24.0,
          child: GameTimer(
            time: duration,
          ),
        ),
        Positioned(
          bottom: 12.0,
          left: 24.0,
          child: GameBestTime(
            bestTime: bestTime,
          ),
        ),
        showConfetti ? const GameConfetti() : const SizedBox(),
      ],
    );
  }
}
