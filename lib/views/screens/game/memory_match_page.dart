import 'package:flutter/material.dart';
import 'package:picture_match/views/widgets/mobile/game_board_mobile.dart';
import 'package:picture_match/views/widgets/web/game_board.dart';

class MemoryMatchPage extends StatelessWidget {
  const MemoryMatchPage({
    required this.gameLevel,
    required this.gameType,
    super.key,
  });

  final int gameLevel;
  final String gameType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: ((context, constraints) {
            if (constraints.maxWidth > 720) {
              return GameBoard(
                gameLevel: gameLevel,
              );
            } else {
              return GameBoardMobile(
                gameLevel: gameLevel,
                gameType: gameType,
              );
            }
          }),
        ),
      ),
    );
  }
}
