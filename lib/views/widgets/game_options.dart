import 'package:flutter/material.dart';
import 'package:picture_match/views/widgets/game_button.dart';

import '../../utils/constants.dart';
import '../screens/game/memory_match_page.dart';

class GameOptions extends StatelessWidget {
  final List<Map<String, dynamic>> gameLevels;
  const GameOptions({super.key, required this.gameLevels});

  static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel) {
    return MaterialPageRoute(
      builder: (_) {
        return MemoryMatchPage(gameLevel: gameLevel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gameLevels.map((level) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GameButton(
            onPressed: () => Navigator.of(context).push(
              _routeBuilder(context, level['level']),
            ), //  (Route<dynamic> route) => false
            title: level['name'],
            color: level['color']![700]!,
            width: 250,
          ),
        );
      }).toList(),
    );
  }
}
