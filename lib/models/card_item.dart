import 'package:flutter/material.dart';

enum CardState { hidden, visible, guessed }

class CardItem {
  CardItem({
    required this.value,
    required this.icon,
    required this.color,
    this.state = CardState.visible,
  });

  final int value;
  final IconData icon;
  final Color color;
  CardState state;
}
