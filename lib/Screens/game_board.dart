import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tetris_game/logic/logic_of_game.dart';
import 'package:tetris_game/pixels.dart';
import 'package:tetris_game/TetrominoShapes/shapes.dart';

// The gameBoard is a 2D list that represents the game grid.
// a non empty space will have the color to represent the landing piece

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);
  @override
  State<GameBoard> createState() => _GameBoardState();
}
class _GameBoardState extends State<GameBoard> {


  @override
  void initState() {
    super.initState();
    // start game when app start
    startGame();

  }
  void startGame(){
    currentPiece.intializePiece();
    Duration frameRate= const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }
  void gameLoop(Duration frameRate){

    Timer.periodic(
        frameRate,
            (timer) {
          setState(() {
            //clear lines
            clearLine();
            //check landing
            checkLadning();
            // check if game is over
            if(gameOver==true){
              timer.cancel();
              showGameOverMessageDialog();
            }
            //move currentPieceDown
            currentPiece.movePiece(Direction.down);
          });
            }
    );
  }

  void showGameOverMessageDialog(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Change the border radius as desired
          ),
          title: Text(
            'GAME OVER',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),),
         content: Container(
           width: double.minPositive, // Adjust the width as desired
           child: Text(
             '\nYour score is : $currentScore',
             style: TextStyle(
                 fontSize: 20
             ),
           ),
         ),
          actions: [
            // to reset the game
            TextButton(
                onPressed:(){
                  resetGame();
                  Navigator.pop(context);
    },
                child: Text('Play Again',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20
                  ),)
            )
          ],
        )
    );
  }
  void resetGame(){
    gameBoard=List.generate(
        columnLength,
            (i) => List.generate(
          rowLength,
              (j)=> null,
        )
    );
    // new game
    currentScore=0;
    gameOver=false;

    createNewPiece();
    startGame();
  }

  // move piece
  void moveLeft(){

    //make sure the piece of valid before moving
    if(!checkCollision(Direction.left )){
      setState((){
        currentPiece.movePiece(Direction.left);
      });
    }
  }
  void moveRight(){
    //make sure the piece of valid before moving
    if(!checkCollision(Direction.right )){
      setState((){
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece(){
    setState(() {
      currentPiece.rotatePiece();
    });
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: rowLength*columnLength,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength
                  ),
                  itemBuilder: (context, index) {
                  //get row and column for each piece
                    int row = (index / rowLength).floor();
                    int column = index % rowLength;

                  if(currentPiece.position.contains(index)){
                    return  Pixels(
                      color: currentPiece.color,
                    );
                  }
                  else if(gameBoard[row][column] !=null){
                    TetrominoShapes? tetrominoShape=gameBoard[row][column];
                    return Pixels(
                        color: tetrominoColor[tetrominoShape],
                        );
                  }
                  //landed pieces
                  else{
                    return  Pixels(
                      color: Colors.grey[900],

                    );
                  }

                }
              ),
            ),
            // GAME SCORE
            Text(
                'Score : $currentScore',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
            // GAME CONTROL
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 40,
                  top: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //left
                  IconButton(
                      onPressed: moveLeft ,
                      icon: Icon(
                          Icons.arrow_back_outlined,
                        color: Colors.white,
                      )
                  ),
                  //rotate
                  IconButton(
                      onPressed: rotatePiece,
                      icon: Icon(
                        Icons.rotate_right_rounded,
                        color: Colors.white,
                      )
                  ),
                  //right
                  IconButton(
                      onPressed: moveRight,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
