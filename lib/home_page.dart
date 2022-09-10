import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _diceList=<String>[
    'images/d1.PNG',
    'images/d2.PNG',
    'images/d3.PNG',
    'images/d4.PNG',
    'images/d5.PNG',
    'images/d6.PNG',
  ];
  int _index1=0, _index2=0, _diceSum=0, _point=0;
  final _random=Random.secure();
  bool _hasGameStarted=false;
  bool _isGameOver=false;
  String _gameStatusMsg='You Lost!!!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple dice game'),
      ),
      body: Center(
        child: _hasGameStarted?_gameSection():_startGameSection(),
      ),
    );
  }
  Widget _startGameSection(){
    return ElevatedButton(onPressed: (){
    setState((){
      _hasGameStarted=true;
    })  ;
    },
        child: const Text('Start'));
    
}
Widget _gameSection(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(_diceList[_index1],width: 100,height: 100,),
            const SizedBox(width: 10,),
            Image.asset(_diceList[_index2],width: 100,height: 100,),

          ],
        ),
        ElevatedButton(
            onPressed: _rollTheDice,
            child: const Text('Roll')
        ),
        Text('Dice Sum:$_diceSum',style:const TextStyle(fontSize: 22,),
        ),
        const SizedBox(height: 10,),
        if(_point>0)Text('Your Point:$_point',
          style: const TextStyle(
              fontSize: 22,color: Colors.green
          ),
        ),
        const SizedBox(height: 10,),
        /*if(_point>0) const Text(
          'Keep rolling until you match your point',
          style: TextStyle(
              fontSize: 18,color: Colors.black45
          )
        ),*/
        if(_isGameOver)Text(
          _gameStatusMsg,
          style:const  TextStyle(
              fontSize: 18,
              color: Colors.black87
          ),
        ),
        if(_isGameOver)ElevatedButton(
            onPressed: (){
            },
            child: const Text('PLAY AGAIN')
        )
      ],
    );

}

  void _rollTheDice() {
    _isGameOver=false;
    setState((){
      _index1=_random.nextInt(6);
      _index2=_random.nextInt(6);
      _diceSum=_index1+_index2+2;
      if(_diceSum==7||_diceSum==11){
        _gameStatusMsg='You Win';
        _isGameOver=true;

      }
      if(_diceSum==2||_diceSum==3||_diceSum==12){
        _gameStatusMsg='You Lose';
        _isGameOver=true;

      }
      if(_diceSum==4||_diceSum==5||_diceSum==6||_diceSum==8||_diceSum==9||_diceSum==10){
        _point=_diceSum;
        _gameStatusMsg='Keep rolling until you match your point';
      };
    });
  }
}
