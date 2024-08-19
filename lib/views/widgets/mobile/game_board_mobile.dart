import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:picture_match/controller/game_option_controller.dart';
import 'package:picture_match/utils/constants.dart';
import 'package:picture_match/views/widgets/custom_card.dart';
import 'package:picture_match/views/widgets/custom_text.dart';
import 'package:picture_match/views/widgets/game_confetti.dart';
import 'package:picture_match/views/widgets/memory_card.dart';
import 'package:picture_match/views/widgets/mobile/game_timer_mobile.dart';
import 'package:picture_match/views/widgets/restart_game.dart';

import '../../../models/game.dart';
import '../../../utils/app_theme.dart';
import '../custom_game_button.dart';

class GameBoardMobile extends StatefulWidget {
  const GameBoardMobile({
    required this.gameLevel,
    required this.gameType,
    required this.limitTime,
    super.key,
  });

  final int gameLevel;
  final String gameType;
  final int limitTime;

  @override
  State<GameBoardMobile> createState() => _GameBoardMobileState();
}

class _GameBoardMobileState extends State<GameBoardMobile> {
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
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: AppTheme.white,
      //   iconTheme: const IconThemeData(color: AppTheme.black),
      //   centerTitle: true,
      //   title: CustomText(
      //     text: ''.tr,
      //     size: 15.sp,
      //     fontWeight: FontWeight.w500,
      //   ),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/bg.webp",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Row(
                      children: [
                        CustomGameButton(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          height: 35.w,
                          width: 35.w,
                          icon: Icons.arrow_back,
                          iconColor: AppTheme.white,
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(
                        width: 1.sw * 0.40,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'best_time'.tr),
                            CustomText(
                              text: Duration(seconds: bestTime)
                                  .toString()
                                  .split('.')
                                  .first
                                  .padLeft(8, "0"),
                            ),
                          ],
                        ),
                      ),
                      isTimeCount
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
                              timeFormatterFunction:
                                  (defaultFormatterFunction, duration) {
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
                              color: AppTheme.green, //Colors.amberAccent[700]!,
                            ),
                      GameTimerMobile(
                        time: duration,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // RestartGame(
                  //   isGameOver: game.isGameFinish,
                  //   pauseGame: () => pauseTimer(),
                  //   restartGame: () => _resetGame(),
                  //   continueGame: () => startTimer(),
                  //   color: Colors.amberAccent[700]!,
                  // ),
                  // GameTimerMobile(
                  //   time: duration,
                  // ),
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
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
                  // GameBestTimeMobile(
                  //   bestTime: bestTime,
                  // ),
                ],
              ),
            ),
            showConfetti ? const GameConfetti() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
