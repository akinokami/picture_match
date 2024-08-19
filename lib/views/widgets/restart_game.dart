import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:picture_match/utils/app_theme.dart';
import 'package:picture_match/views/widgets/game_controls_bottomsheet.dart';

class RestartGame extends StatelessWidget {
  const RestartGame({
    required this.isGameOver,
    required this.pauseGame,
    required this.restartGame,
    required this.continueGame,
    this.color = Colors.green,
    super.key,
  });

  final VoidCallback pauseGame;
  final VoidCallback restartGame;
  final VoidCallback continueGame;
  final bool isGameOver;
  final Color color;

  Future<void> showGameControls(BuildContext context) async {
    pauseGame();
    var value = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (sheetContext) {
        return const GameControlsBottomSheet();
      },
    );

    value ??= false;

    if (value) {
      restartGame();
    } else {
      continueGame();
    }
  }

  void navigateback(BuildContext context) {
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) {
    //   return const StartUpPage();
    // }), (Route<dynamic> route) => false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          isGameOver ? navigateback(context) : showGameControls(context),
      child: Container(
          height: 35.w,
          width: 35.w,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              width: 3.w,
              color: AppTheme.premiumColor2,
            ),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Icon(
            isGameOver
                ? Icons.keyboard_double_arrow_right
                : Icons.pause_circle_filled,
            size: 18.sp,
            color: Colors.white,
          )
          // IconButton(

          //   icon: (isGameOver)
          //       ? const Icon(Icons.replay_circle_filled)
          //       : const Icon(Icons.pause_circle_filled),
          //   iconSize: 40,
          //   onPressed: () =>
          //       isGameOver ? navigateback(context) : showGameControls(context),
          // ),
          ),
    );
  }
}

// IconButton(
//         color: color,
//         icon: (isGameOver)
//             ? const Icon(Icons.replay_circle_filled)
//             : const Icon(Icons.pause_circle_filled),
//         iconSize: 40,
//         onPressed: () =>
//             isGameOver ? navigateback(context) : showGameControls(context),
//       ),