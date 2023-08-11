import 'package:flutter/material.dart';
import 'package:tetris_game/TetrominoShapes/shapes.dart';
import 'package:tetris_game/logic/logic_of_game.dart';

class Piece {
  //type of tetris pieces

  TetrominoShapes type;
  Piece({
    required this.type
  });

  //the piece is just a list of integers
 List<int> position=[];

 //color of tetris piece
 Color get color{
   return tetrominoColor[type]??
   const Color(0xffffffff);
 }


 //generate the shapes integers

  // -30  -29  -28  -27  -26  -25  -24  -23  -22  -21
  // -20  -19  -18  -17  -16  -15   -14  -13   -12 -11
  // -10   -9   -8   -7  -6   -5    -4    -3    -2   -1
  //  0    1     2    3    4   5     6     7    8   9
  //  10   11   12   13   14   15   16   17   18   19
  void intializePiece(){

    switch(type){

      case TetrominoShapes.L:
        position=[
          -26,
          -16,
          -6,
          -5
        ];
        break;

      case TetrominoShapes.J:
        position=[
          -25,
          -15,
          -5,
          -6
        ];
        break;
      case TetrominoShapes.I:
        position=[
          -7,
          -6,
          -5,
          -4
        ];
        break;
      case TetrominoShapes.O:
        position=[
          -16,
          -15,
          -5,
          -6
        ];
        break;
      case TetrominoShapes.S:
        position=[
          -15,
          -14,
          -6,
          -5
        ];
        break;
      case TetrominoShapes.T:
        position=[
          -26,
          -16,
          -6,
          -15
        ];
        break;
      case TetrominoShapes.Z:
        position=[
          -17,
          -16,
          -6,
          -5
        ];
        break;
      default :
    }

  }


void movePiece(Direction direction){

  switch(direction){

    case Direction.left:
     for(int i=0;i<position.length;i++){
       position[i] -= 1;
     }
      break;
    case Direction.right:
      for(int i=0;i<position.length;i++){
        position[i] += 1;
      }
      break;
    case Direction.down:
      for(int i=0;i<position.length;i++){
        position[i] +=rowLength;
      }
      break;
    default :
  }

}

  int rotationState=1;

  void rotatePiece(){
    //new position
    List<int> newPosition=[];
    //rotate the piece depend on it's type
    switch(type){
      case TetrominoShapes.L:
        switch(rotationState){
          case 0:
          //    X
          //    X
          //    X  X  X

          //get the new position
            {
              newPosition=[
                position[1]-rowLength,
                position[1],
                position[1]+rowLength,
                position[1]+rowLength+1
              ];
              //check that this new position is valid before assign
              // it to the new position
              if(piecePositionIsValid(newPosition)){
                //update position
                position=newPosition;
                // update rotation state
                rotationState=(rotationState+1 )%4;
              }}
            break;

          case 1:
          //  X X X
          //  X
          //  X
          //get the new position
            {newPosition=[
              position[1]-1,
              position[1],
              position[1]+1 ,
              position[1]+rowLength-1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 2:
          // X X X
          //       X
          //       X
          //get the new position
            {newPosition=[
              position[1]+rowLength,
              position[1],
              position[1]-rowLength,
              position[1]-rowLength-1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }
            }
            break;

          case 3:
          //    X
          //      X
          //  X X X
          //get the new position
            {newPosition=[
              position[1] - rowLength + 1,
              position[1],
              position[1]+1,
              position[1]-1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState= 0;
            }}
            break;
        }
        break;
      case TetrominoShapes.S:
        switch(rotationState){
          case 0:
          //    X X
          //  X X

          //get the new position
            {newPosition=[
              position[1],
              position[1] +1,
              position[1] + rowLength -1,
              position[1] + rowLength
            ];
            //check that this new position is valid before assign
            // it to the new position
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 1:
          //  X
          //  X X
          //    X
          //get the new position
            {newPosition=[
              position[0]-rowLength,
              position[0],
              position[0]+1 ,
              position[0]+rowLength+1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 2:
          //    X X
          //  x x
          //get the new position
            {newPosition=[
              position[1],
              position[1] +1,
              position[1] + rowLength - 1,
              position[1] + rowLength
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }
            }
            break;

          case 3:
          //    X
          //    X x
          //      X
          //get the new position
            {newPosition=[
              position[0]-rowLength,
              position[0],
              position[0]+1 ,
              position[0]+rowLength+1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState= 0;
            }}
            break;
        }
        break;

      case TetrominoShapes.I:
        switch(rotationState){
          case 0:
          //
          //
          //  X  X  X  X

          //get the new position
            {newPosition=[
              position[1]-1,
              position[1],
              position[1]+1,
              position[1]+2
            ];
            //check that this new position is valid before assign
            // it to the new position
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 1:
          //  X
          //  X
          //  X
          //  x
          //get the new position
            {newPosition=[
              position[1]-rowLength,
              position[1],
              position[1]+rowLength ,
              position[1]+ 2*rowLength
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 2:
          //  X X X x
          //
          //
          //get the new position
            {newPosition=[
              position[1]+1,
              position[1],
              position[1]-1,
              position[1]-2
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }
            }
            break;

          case 3:
          //      X
          //      X
          //      X
          //get the new position
            {newPosition=[
              position[1]+rowLength,
              position[1],
              position[1]-rowLength ,
              position[1]- 2*rowLength
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState= 0;
            }}
            break;
        }
        break;
      case TetrominoShapes.O:
      //X X
      //  X X
      //DOESN'T NEED TO ROTATE
        break;

      case TetrominoShapes.J:
        switch(rotationState){
          case 0:
          //     X
          //     X
          // X X X

          //get the new position
            {newPosition=[
              position[1]-rowLength,
              position[1],
              position[1]+rowLength,
              position[1]+rowLength-1
            ];
            //check that this new position is valid before assign
            // it to the new position
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 1:
          //  X
          //  X X X
          //
          //get the new position
            {newPosition=[
              position[1]-rowLength-1,
              position[1],
              position[1]-1 ,
              position[1]+1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 2:
          // X X X
          // X
          // X
          //get the new position
            {newPosition=[
              position[1]+rowLength,
              position[1],
              position[1]-rowLength,
              position[1]-rowLength+1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }
            }
            break;

          case 3:
          //  X  X  X
          //        X
          //        X
          //get the new position
            {newPosition=[
              position[1] + 1,
              position[1],
              position[1]-1,
              position[1] + rowLength + 1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState= 0;
            }}
            break;
        }
        break;

      case TetrominoShapes.Z:
        switch(rotationState){
          case 0:
          //  X X
          //    X X
          //get the new position
            {newPosition=[
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1
            ];
            //check that this new position is valid before assign
            // it to the new position
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 1:
          //   X
          // X X
          // X
          //get the new position
            {newPosition=[
              position[0]- rowLength + 2,
              position[1],
              position[2] - rowLength + 1 ,
              position[3] - 1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 2:
          // X X
          //   X x
          //get the new position
            {newPosition=[
              position[0] + rowLength -2 ,
              position[1],
              position[2] + rowLength -1,
              position[3] +1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }
            }
            break;

          case 3:
          //    x
          //  x x
          //  x
          //get the new position
            {newPosition=[
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength +1,
              position[3]-1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState= 0;
            }}
            break;
        }
        break;

      case TetrominoShapes.T:
        switch(rotationState){
          case 0:
          //  X
          //  x X X
          //  x
          //get the new position
            {newPosition=[
              position[2] - rowLength ,
              position[2],
              position[2] + 1,
              position[2] + rowLength
            ];
            //check that this new position is valid before assign
            // it to the new position
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 1:
          //
          // X X X
          //   X
          //get the new position
            {newPosition=[
              position[1]- 1,
              position[1],
              position[1] + 1 ,
              position[1] + rowLength
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }}
            break;

          case 2:
          //   X
          // X X
          //   x
          //get the new position
            {newPosition=[
              position[1] - rowLength  ,
              position[1] - 1,
              position[1] ,
              position[1] + rowLength
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState=(rotationState+1 )%4;
            }
            }
            break;

          case 3:
          //    x
          //  x x x
          //get the new position
            {newPosition=[
              position[2] - rowLength ,
              position[2] - 1,
              position[2],
              position[2] + 1
            ];
            if(piecePositionIsValid(newPosition)){
              //update position
              position=newPosition;
              // update rotation state
              rotationState= 0; // reset rotation state to 0
            }}
            break;
        }
        break;


      default:

    }
  }

  //check if valid position
  bool positionIsValid(int position){
    //get the row and col of position
    int row = (position/rowLength).floor();
    int col = position%rowLength;
    //if the position is taken return false
    if(row<0 || col<0 || gameBoard[row][col] !=null){
      return false;
    }
    //otherwise position is valid return true
    else{
      return true;
    }

  }
//check if piece valid position
  bool piecePositionIsValid(List<int> piecePosition){
    bool firstColOccupied=false;
    bool lastColOccupied=false;
    for(int pos in piecePosition){
      if(!positionIsValid(pos)){
        return false;
      }
      //check for first column or last column is occupied
      int col = pos%rowLength;
      if(col ==0){
        firstColOccupied=true;
      }
      if(col == rowLength -1){
        lastColOccupied=true;
      }
      //if there is any piece in the first column or last column
      // will go through the wall
    }
    return !(firstColOccupied && lastColOccupied);

  }

}