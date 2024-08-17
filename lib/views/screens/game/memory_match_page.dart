import 'package:flutter/material.dart';
import 'package:picture_match/views/widgets/mobile/game_board_mobile.dart';
import 'package:picture_match/views/widgets/web/game_board.dart';

class MemoryMatchPage extends StatelessWidget {
  const MemoryMatchPage({
    required this.gameLevel,
    required this.gameType,
    required this.limitTime,
    super.key,
  });

  final int gameLevel;
  final String gameType;
  final int limitTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: ((context, constraints) {
            print(constraints.maxWidth);
            if (constraints.maxWidth > 800) {
              //720
              return GameBoard(
                gameLevel: gameLevel,
                gameType: gameType,
                limitTime: limitTime,
              );
            } else {
              return GameBoardMobile(
                gameLevel: gameLevel,
                gameType: gameType,
                limitTime: limitTime,
              );
            }
          }),
        ),
      ),
    );
  }
}
