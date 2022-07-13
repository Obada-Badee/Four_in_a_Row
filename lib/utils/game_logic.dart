class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardLength = 42;
  static final maxRow = 5;
  static final maxCol = 6;
  static final blocSize = 100.0;

  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardLength, (index) => Player.empty);

  bool winnerCheck(
      String player, int row, int col, List<List<int>> gameScoreBoard) {
    int score = player == 'X' ? 1 : -1;
    gameScoreBoard[row][col] = score;

    int count = 0;

// Horizontal check
    for (int i = 0; i < maxCol; i++) {
      if (gameScoreBoard[row][i] == score) {
        count++;
      } else {
        count = 0;
      }

      if (count >= 4) return true;
    }
//Vertical check
    for (int i = 0; i < maxRow; i++) {
      if (gameScoreBoard[i][col] == score) {
        count++;
      } else {
        count = 0;
      }

      if (count >= 4) return true;
    }
    count = 0;
// 4 in a row diagonally
    for (int i = col + 1, j = row + 1; i < maxRow && j < maxCol; i++, j++) {
      if (gameScoreBoard[j][i] != score) {
        count = 1;
        break;
      }
      count++;
    }
// 4 in a row diagonally
    for (int i = col - 1, j = row - 1; i >= 0 && j >= 0; i--, j--) {
      if (gameScoreBoard[j][i] != score) {
        count = 1;
        break;
      }
      count++;
    }
// 4 in a row diagonally
    for (int i = col + 1, j = row - 1; i < maxRow && j >= 0; i++, j--) {
      if (gameScoreBoard[j][i] != score) {
        count = 1;
        break;
      }
      count++;
    }

    for (int i = col - 1, j = row + 1; i >= 0 && j < maxCol; i--, j++) {
      // 4 in a row diagonally
      if (gameScoreBoard[j][i] != score) {
        count = 1;
        break;
      }
      count++;
    }

    if (count >= 4) {
      return true;
    }

    return false;
  }
}
