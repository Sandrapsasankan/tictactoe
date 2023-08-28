import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));

  String currentPlayer = 'X';
  String winner = '';
  int playerXScore = 0;
  int playerOScore = 0;

  void makeMove(int row, int col) {
    if (board[row][col] == '' && winner.isEmpty) {
      setState(() {
        board[row][col] = currentPlayer;
        checkWinner(row, col);
        if (winner.isEmpty) {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        } else {
          if (winner == 'X') {
            playerXScore++;
          } else if (winner == 'O') {
            playerOScore++;
          }
        }
      });
    }
  }

  void checkWinner(int row, int col) {
    String player = board[row][col];

    // Check row
    if (board[row].every((cell) => cell == player)) {
      winner = player;
      return;
    }

    // Check column
    if (board.every((row) => row[col] == player)) {
      winner = player;
      return;
    }

    // Check diagonals
    if (row == col && board.every((row) => row[col] == player)) {
      winner = player;
      return;
    }

    if (row + col == 2 && board.every((row) => row[2 - row.indexOf(player)] == player)) {
      winner = player;
      return;
    }
  }

  void resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      currentPlayer = 'X';
      winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              winner.isEmpty ? "Player's Turn: $currentPlayer" : "Winner: $winner",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Player X Score: $playerXScore'),
              SizedBox(width: 20),
              Text('Player O Score: $playerOScore'),
            ],
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              int row = index ~/ 3;
              int col = index % 3;
              return GestureDetector(
                onTap: () => makeMove(row, col),
                child: Container(
                  color: Colors.blueGrey,
                  child: Center(
                    child: Text(
                      board[row][col],
                      style: TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetBoard,
            child: Text('Reset Board'),
          ),
        ],
      ),
    );
  }
}
