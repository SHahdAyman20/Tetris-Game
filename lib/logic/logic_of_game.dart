import 'package:tetris_game/TetrominoShapes/pieces.dart';
import 'package:tetris_game/TetrominoShapes/shapes.dart';
import 'dart:math';

//create game board
 List<List<TetrominoShapes?>> gameBoard=List.generate(
     columnLength,
         (i) => List.generate(
           rowLength,
               (j)=> null,
         )
);

 Piece currentPiece=Piece(type: TetrominoShapes.L);

 int currentScore=0;
 bool gameOver= false;


 //check for collision of the future position
   // return true => if there is a collision
      // return false => if there is no collision
 bool checkCollision(Direction direction) {
  //loop through each position of the current piece
  for(int i=0 ; i< currentPiece.position.length; i++){
    //calculate the row and column of current position
    int row=(currentPiece.position[i] / rowLength).floor();
    int column=currentPiece.position[i] % rowLength;
    // adjust row and column based on the direction
    if(direction==Direction.left){
      column -=1;
    }else if(direction==Direction.right){
      column +=1;
    }else if(direction==Direction.down){
      row +=1;
    }
    //check if the piece is out of bounds(either too low or too far from right or left)
    if(row>=columnLength || column<0 || column>=rowLength){
      return true;
    }

  }
  //if no collision is detected
  return false;
}

 void checkLadning(){
  //if going down is occupied
  if(checkCollision(Direction.down) || checkLanded() ){
    // mark position as occupied in the game board
    for(int i=0;i< currentPiece.position.length; i++) {
      //calculate the row and column of current position
      int row = (currentPiece.position[i] / rowLength).floor();
      int column = currentPiece.position[i] % rowLength;
      if(row>=0 && column>=0){
        gameBoard[row][column]=currentPiece.type;
      }
    }
    // once landed, create the next piece

    createNewPiece();
  }
}

 bool checkLanded() {
  // loop through each position of the current piece
  for (int i = 0; i < currentPiece.position.length; i++) {
    int row = (currentPiece.position[i] / rowLength).floor();
    int col = currentPiece.position[i] % rowLength;

    // check if the cell below is already occupied
    if (row + 1 < columnLength && row >= 0 && gameBoard[row + 1][col] != null) {
      return true; // collision with a landed piece
    }
  }

  return false; // no collision with landed pieces
}
// clear line
 void clearLine(){
  // 1) loop through each row of game board from the bottom to the top
  for(int row= columnLength -1 ; row >= 0 ; row --){
    // 2) initialize variable to track if row is full
    bool rowIsFull= true;
    // 3) check if the row is full ( all columns in the row are filled with pieces )
    for(int col=0 ; col< rowLength ; col++){
      // if there is an empty column, set rowIsFull is false and break the loop
      if(gameBoard[row][col] == null){
        rowIsFull = false;
        break;
      }
    }
    // 4) if row is full, clear the row and shift rows down
    if(rowIsFull){
      // 5) move all rows above the cleared row down by one position
      for(int r=row ; r >0 ; r--){
        // copy the above row to the current row
        gameBoard[r]=List.from(gameBoard[r-1]);
      }
      // 6) set the top row to empty
      gameBoard[0]=List.generate(row, (index) => null);
      // 7) increase the score
      currentScore++;
    }
  }
}

 bool isGameOver(){
  // CHECK IF ANY COLUMNS IN THE TOP ROW ARE FILLED
  for(int col=0 ; col< rowLength ; col++){
    if(gameBoard[0][col] != null){
      return true;
    }
  }
  // if the top row is empty, the fame not over
  return false;
}

 void createNewPiece(){
// create a random object to generate a random shape
  Random random=Random();
  // create  a new piece withe random type
  TetrominoShapes randomShape=
  TetrominoShapes.values[random.nextInt(
      TetrominoShapes.values.length
  )];
  currentPiece=Piece(type: randomShape);
  currentPiece.intializePiece();

  /*
  since our game over condition is if there is a piece at the
  top level, you want to check if the game is over when you created
  a new piece, instead checking every frame, because new pieces are
  allowed to go through the top level, but if there already a piece
  in the top row when a new piece is created,
  -----> then game is over <--------
   */
   if(isGameOver()){
     gameOver= true;
   }


}

