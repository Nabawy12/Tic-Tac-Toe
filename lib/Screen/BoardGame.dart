import 'package:flutter/material.dart';
import 'package:xogame/Screen/Table.dart';
import 'package:xogame/Screen/players.dart';

class Boardgame extends StatefulWidget {
  static const routeName = '/Boardgame';

  const Boardgame({super.key});

  @override
  State<Boardgame> createState() => _BoardgameState();
}

class _BoardgameState extends State<Boardgame> {
  int counter = 0;
  int scorePlayer1 = 0;
  int scorePlayer2 = 0;
  List<String> boardState = List.filled(9, '');
  bool isSinglePlayer = true; // This flag means one user vs bot
  String currentPlayer = 'X'; // X is always the user, O is bot

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as players;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Score Board section
            Container(
              alignment: Alignment.center,
              color: Colors.grey,
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Player 1 Score (X)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${args.playerName1} (X)", style: TextStyle(fontSize: 25)),
                      SizedBox(height: 5),
                      Text(scorePlayer1.toString(), style: TextStyle(fontSize: 25)),
                    ],
                  ),
                  SizedBox(width: 15),
                  // Player 2 Score (O)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${args.playerName2} (O)", style: TextStyle(fontSize: 25)),
                      SizedBox(height: 5),
                      Text(scorePlayer2.toString(), style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),

            // 3x3 Board
            for (int row = 0; row < 3; row++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int col = 0; col < 3; col++)
                    buttonPlay(
                      text: boardState[row * 3 + col],
                      index: row * 3 + col,
                      onClick: handleTap,
                    ),
                ],
              ),

            Spacer(),
          ],
        ),
      ),
    );
  }

  // This function handles when user clicks on any square
  void handleTap(int index) {
    if (boardState[index] != '') return; // if already filled, ignore

    setState(() {
      boardState[index] = 'X'; // player move
      counter++;
    });

    String winner = checkWinner();
    if (winner != '') return showWinnerDialog(winner);

    // Now the bot will move if single player mode is on
    if (isSinglePlayer) {
      Future.delayed(Duration(milliseconds: 400), () {
        int bestMove = findBestMove(boardState);
        setState(() {
          boardState[bestMove] = 'O'; // bot move
          counter++;
        });

        String winner = checkWinner();
        if (winner != '') return showWinnerDialog(winner);
      });
    }
  }

  // This function returns the winner or empty if game not ended
  String checkWinner() {
    List<List<int>> winPositions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
      [0, 4, 8], [2, 4, 6],           // diagonals
    ];

    for (var positions in winPositions) {
      String a = boardState[positions[0]];
      String b = boardState[positions[1]];
      String c = boardState[positions[2]];
      if (a != '' && a == b && b == c) {
        return a;
      }
    }

    if (!boardState.contains('')) {
      return 'Draw'; // all cells filled
    }

    return ''; // no winner yet
  }

  // This function shows the result dialog
  void showWinnerDialog(String winner) {
    String message;
    if (winner == 'Draw') {
      message = 'It\'s a Draw!';
    } else if (winner == 'X') {
      scorePlayer1++;
      message = 'Player X Wins!';
    } else {
      scorePlayer2++;
      message = 'Player O Wins!';
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Game Over'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                boardState = List.filled(9, '');
                counter = 0;
              });
              Navigator.pop(context);
            },
            child: Text('Play Again'),
          )
        ],
      ),
    );
  }

  // This is the AI logic (Minimax Algorithm)
  int findBestMove(List<String> board) {
    int bestScore = -1000;
    int move = -1;

    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        int score = minimax(board, 0, false);
        board[i] = '';
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }

    return move;
  }

  // Minimax algorithm for the bot to play optimally
  int minimax(List<String> board, int depth, bool isMaximizing) {
    String winner = checkWinnerMini(board);
    if (winner == 'O') return 10 - depth;
    if (winner == 'X') return depth - 10;
    if (!board.contains('')) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'O';
          bestScore = max(bestScore, minimax(board, depth + 1, false));
          board[i] = '';
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'X';
          bestScore = min(bestScore, minimax(board, depth + 1, true));
          board[i] = '';
        }
      }
      return bestScore;
    }
  }

  // Helper function to check winner during minimax
  String checkWinnerMini(List<String> board) {
    List<List<int>> winPositions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6],
    ];

    for (var pos in winPositions) {
      String a = board[pos[0]];
      String b = board[pos[1]];
      String c = board[pos[2]];
      if (a != '' && a == b && b == c) return a;
    }

    return '';
  }

  // Helper max function
  int max(int a, int b) => a > b ? a : b;

  // Helper min function
  int min(int a, int b) => a < b ? a : b;
}
