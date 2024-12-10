import 'package:flutter/material.dart';
void main(){
  runApp(tictactoe());
}
class tictactoe extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: tictactoegame(),
    );
  }
}
class tictactoegame extends StatefulWidget{
  @override
  _tictactoegameState createState()=> _tictactoegameState();
}
class _tictactoegameState extends State<tictactoegame>{
  List<String>board=List.filled(9, '');
  String currentplayer ='';
  int player1score=0;
  int player2score=0;
  String winner='';
  void resetboard(){
    setState(() {
      board=List.filled(9, '');
      winner='';});
  }
  void resetgame(){
    setState(() {
      player1score=0;
      player2score=0;
      resetboard();
    });
  }
  void handletap(int index){
    if(board[index]==''&& winner==''){
      setState(() {
        board[index]=currentplayer;
        if(checkwinner()) {
          winner = currentplayer;
          if (currentplayer == 'X') {
            player1score++;
          }
          else {
            player2score++;
          }
        }
        else if(!board.contains('')){
          winner='Draw';
        }
        currentplayer=(currentplayer=='X')?'0':'X';
      }
      );
    }
  }
  bool checkwinner(){
    const winningpatterns =[
      [0,1,2],[3,4,5],[6,7,8],
      [0,3,6],[1,4,7],[2,5,8],
      [0,4,8],[2,4,6],
    ];
    for(var pattern in winningpatterns){
      if(board[pattern[0]]!=''&&board[pattern[0]]==board[pattern[1]]&&
          board[pattern[0]]==board[pattern[2]]){
        return true;
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('TIC TAC TOE'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildscoreboard('Player 1','X',player1score),
                buildscoreboard('player 2','O',player2score),
              ],
            ),),
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildrow([0,1,2]),
              buildrow([3,4,5]),
              buildrow([6,7,8]),
            ],),),
          Text(
            winner.isNotEmpty
                ? 'Winner: $winner'
                :'Current player: $currentplayer',
            style: TextStyle(color: Colors.white,fontSize: 20),
          ),
          Padding(padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children: [
                ElevatedButton(onPressed: resetboard,style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text('Restart'),
                ),
              ],
            ),),
        ],
      ),
    );
  }
  Widget buildrow(List<int>indices){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indices.map((index){
        return GestureDetector(
          onTap: ()=> handletap(index),
          child: Container(
            margin: EdgeInsets.all(4.0),
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                board[index],
                style: TextStyle(
                  color: board[index]=='X'? Colors.red:Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
  Widget buildscoreboard(String player, String symbol, int score){
    return Column(
      children: [
        Text(player,style: TextStyle(color: Colors.white,fontSize: 16),
        ),
        Text('$symbol: $score',style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}