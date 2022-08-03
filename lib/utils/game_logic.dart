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
    for (int i = 0; i <= maxCol; i++) {
      if (gameScoreBoard[row][i] == score) {
        count++;
      } else {
        count = 0;
      }

      if (count >= 4) return true;
    }
//Vertical check
    for (int i = 0; i <= maxRow; i++) {
      if (gameScoreBoard[i][col] == score) {
        count++;
      } else {
        count = 0;
      }

      if (count >= 4) return true;
    }
    count = 0;

////////
    for (int rowStart = 0; rowStart <= maxRow - 4; rowStart++) {
      count = 0;
      for (int row2 = rowStart, col2 = 0;
          row2 <= maxRow && col2 <= maxCol;
          row2++, col2++) {
        if (gameScoreBoard[row2][col2] == score) {
          count++;
          if (count >= 4) {
            return true;
          }
        } else {
          count = 0;
        }
      }
    }

// top-left to bottom-right - red diagonals
    for (int colStart = 1; colStart <= maxCol - 4; colStart++) {
      count = 0;
      for (int row2 = 0, col2 = colStart;
          row2 <= maxRow && col2 <= maxCol;
          row2++, col2++) {
        if (gameScoreBoard[row2][col2] == score) {
          count++;
          if (count >= 4) {
            return true;
          }
        } else {
          count = 0;
        }
      }
    }

    ////////THE OTHER SIDE OF THE   GREEN DIAGONAL
    for (int rowStart = maxRow; rowStart > maxRow - 4; rowStart--) {
      count = 0;
      for (int row2 = rowStart, col2 = 0;
          row2 >= 0 && col2 <= maxCol;
          row2--, col2++) {
        if (gameScoreBoard[row2][col2] == score) {
          count++;
          if (count >= 4) {
            return true;
          }
        } else {
          count = 0;
        }
      }
    }

// top-left to bottom-right - red diagonals - THE OTHER SIDE
    for (int colStart = 1; colStart <= maxCol - 4; colStart++) {
      count = 0;
      for (int row2 = maxRow, col2 = colStart;
          row2 >= 0 && col2 <= maxCol;
          row2--, col2++) {
        if (gameScoreBoard[row2][col2] == score) {
          count++;
          if (count >= 4) {
            return true;
          }
        } else {
          count = 0;
        }
      }
    }

    if (count >= 4) {
      return true;
    }

    return false;
  }
}
