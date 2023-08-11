//game board dimension
import 'package:flutter/painting.dart';

int rowLength=10;
int columnLength=15;

enum Direction{
  left,
  right,
  down
}
enum TetrominoShapes{


  L,
  J,
  I,
  O,
  S,
  Z,
  T
}

 Map<TetrominoShapes, Color> tetrominoColor={
   TetrominoShapes.L :Color(0xFFFFA500),
   TetrominoShapes.J :Color(0xff045AFA),
   TetrominoShapes.I :Color.fromARGB(255, 232, 11, 147),
   TetrominoShapes.O :Color(0xFFFFff00),
   TetrominoShapes.S :Color(0xFF12C800),
   TetrominoShapes.Z :Color(0xFFEE0000),
   TetrominoShapes.T :Color.fromARGB(255, 144, 26, 190),

 };
/*   x
*    x                x x              x x x x
*    x                x x
*    x x x
*                              x x x
*                                x x x
*
*            x x x
*         x x x                x x x             x
*                                x               x
*                                x               x
*                                            x x x
* */