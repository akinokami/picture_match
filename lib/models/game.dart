import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picture_match/models/card_item.dart';
import 'package:picture_match/utils/icons.dart';

class Game {
  Game(this.gridSize) {
    generateCards();
  }
  final int gridSize;

  List<CardItem> cards = [];
  bool isGameFinish = false;
  Set<IconData> icons = {};
  bool isGameOver = false;

  void generateCards() {
    generateIcons();
    cards = [];
    final List<Color> cardColors = Colors.primaries.toList();
    if (gridSize % 2 != 0) {
      for (int i = 0; i < ((gridSize * (gridSize + 1)) / 2); i++) {
        final cardValue = i + 1;
        final IconData icon = icons.elementAt(i);
        final Color cardColor = cardColors[i % cardColors.length];
        final List<CardItem> newCards =
            _createCardItems(icon, cardColor, cardValue);
        cards.addAll(newCards);
      }
    } else {
      for (int i = 0; i < (gridSize * gridSize / 2); i++) {
        final cardValue = i + 1;
        final IconData icon = icons.elementAt(i);
        final Color cardColor = cardColors[i % cardColors.length];
        final List<CardItem> newCards =
            _createCardItems(icon, cardColor, cardValue);
        cards.addAll(newCards);
      }
    }

    cards.shuffle(Random());
  }

  void generateIcons() {
    icons = <IconData>{};
    if (gridSize % 2 != 0) {
      for (int j = 0; j < (gridSize * (gridSize + 1) / 2); j++) {
        final IconData icon = _getRandomCardIcon();
        icons.add(icon);
        icons.add(icon);
      }
    } else {
      for (int j = 0; j < (gridSize * gridSize / 2); j++) {
        final IconData icon = _getRandomCardIcon();
        icons.add(icon);
        icons.add(icon);
      }
    }
  }

  void resetGame() {
    generateCards();
    isGameFinish = false;
    isGameOver = false;
  }

  void onCardPressed(int index) {
    cards[index].state = CardState.visible;
    final List<int> visibleCardIndexes = _getVisibleCardIndexes();
    if (visibleCardIndexes.length == 2) {
      final CardItem card1 = cards[visibleCardIndexes[0]];
      final CardItem card2 = cards[visibleCardIndexes[1]];
      if (card1.value == card2.value) {
        card1.state = CardState.guessed;
        card2.state = CardState.guessed;
        isGameFinish = _isGameOver();
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          card1.state = CardState.hidden;
          card2.state = CardState.hidden;
        });
      }
    }
  }

  List<CardItem> _createCardItems(
      IconData icon, Color cardColor, int cardValue) {
    return List.generate(
      2,
      (index) => CardItem(
        value: cardValue,
        icon: icon,
        color: cardColor,
      ),
    );
  }

  IconData _getRandomCardIcon() {
    final Random random = Random();
    IconData icon;
    do {
      icon = cardIcons[random.nextInt(cardIcons.length)];
    } while (icons.contains(icon));
    return icon;
  }

  List<int> _getVisibleCardIndexes() {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == CardState.visible)
        .map((entry) => entry.key)
        .toList();
  }

  bool _isGameOver() {
    return cards.every((card) => card.state == CardState.guessed);
  }
}
