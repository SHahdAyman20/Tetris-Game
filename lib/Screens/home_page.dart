import 'package:flutter/material.dart';
import 'package:tetris_game/Screens/game_board.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/tetris.png"
              ),
              fit: BoxFit.cover
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute (
                  builder: (BuildContext context) => const GameBoard(),
                ),
              );
            },
            child: Text(
              'PLAY',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                color: Colors.black54

              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color(0xffD9D9D9)
              )
            ),
          ),
        ),
      ]
    );
  }
}
