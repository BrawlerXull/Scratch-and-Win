

import 'package:flutter/material.dart';
import 'dart:math';
class HomePage extends StatefulWidget {
  @override
   _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");
  List<String> itemArray;
  int luckyNumber;
  int play_counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }
  generateRandomNumber(){
    int randomNumber = Random().nextInt(25);
    setState(() {
      luckyNumber = randomNumber;
    });
  }

    AssetImage getImage(int index){
      String currentState = itemArray[index];
      switch (currentState) {
        case "lucky":
          return lucky;
          break;
        case "unlucky":
          return unlucky;
          break;
      }
      return circle;
    }

  playGame(int index) {
    
    if(luckyNumber == index) {
       setState(() {
          itemArray[index] = "lucky";
          play_counter = play_counter + 1;
      });
    }
    else {
      setState(() {
        itemArray[index] = "unlucky";
        play_counter = play_counter + 1;
      });
    }
    if(play_counter == 5 ) {
      Future.delayed(const Duration(milliseconds: 1000), () {
          showAll();
      });
      
      Future.delayed(const Duration(milliseconds: 1000), () {
        resetGame();
        play_counter = 0;
      });
    }  
  }

  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky"; 
    });
  }


  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateRandomNumber();
  }


   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0
              ), 
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              )
            ) 
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: (){
                  this.showAll();
                },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
                child: Text('Show All',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: (){
                  this.resetGame();
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
                child: Text('Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )
                ),
              ),
            ),
          ),
            
          )   
        ],
      ),
    );
  }
}  
