import 'package:flutter/material.dart';
import 'package:tetris_game/Screens/game_board.dart';
import 'package:tetris_game/Screens/home_page.dart';

void main() {
  runApp( TetrisGame());
}

class TetrisGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TETRIS Game',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}



