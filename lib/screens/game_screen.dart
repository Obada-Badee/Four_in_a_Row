import 'package:flutter/material.dart';
import 'package:four_in_a_row/ui/theme/color.dart';
import 'package:four_in_a_row/utils/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; // to check the draw
  String gameResult = "";
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
  var gameScoreBoard = List.generate(
      6, (i) => List.filled(7, 0, growable: false),
      growable: false);

  // My code starts here
  List<int> rowFilled = [5, 5, 5, 5, 5, 5, 5];

  Game game = Game();

  //let's initi the GameBoard
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
    print(rowFilled);
    print(gameScoreBoard);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's $lastValue turn".toUpperCase(),
            style: const TextStyle(
                color: Colors.amber,
                fontSize: 38,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto"),
          ),
          const SizedBox(
            height: 20.0,
          ),
          // ignore: sized_box_for_whitespace
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 6,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardLength, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          int chosenCol = index % 7;
                          int chosenRow = rowFilled[chosenCol];
                          if (chosenRow > -1) {
                            int chosenIndex = (chosenRow) * 7 + chosenCol;

                            setState(() {
                              game.board![chosenIndex] = lastValue;
                              rowFilled[chosenCol]--;
                              print(rowFilled);
                              print(chosenRow);
                              turn++;
                              gameOver = game.winnerCheck(lastValue, chosenRow,
                                  chosenCol, gameScoreBoard);

                              if (gameOver) {
                                gameResult =
                                    lastValue = "$lastValue is the winner";
                              } else if (!gameOver && turn == 42) {
                                gameResult = "Its a draw";
                                gameOver = true;
                              }
                              //Wont chanhge
                              if (lastValue == "X") {
                                lastValue = "O";
                              } else {
                                lastValue = "X";
                              }
                            });
                          }
                        },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == "X"
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 25.0),
          Text(
            gameResult,
            style: const TextStyle(color: Colors.white, fontSize: 54.0),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameResult = "";
                turn = 0;
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
                gameOver = false;
                rowFilled = [5, 5, 5, 5, 5, 5, 5];
                gameScoreBoard = List.generate(
                    6, (i) => List.filled(7, 0, growable: false),
                    growable: false);
              });
            },
            icon: Icon(Icons.replay),
            label: Text("Restart"),
          ),
        ],
      ),
    );
  }
}
