import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import '../components/simon_button.dart';

class Board extends StatefulWidget {
  final Function nextLevel;
  final Function nextStep;
  final String currentStep;
  final String level;
  final String record;
  final bool canPlay;
  final int pressed;

  Board(
      {this.nextLevel,
      this.nextStep,
      this.canPlay,
      this.level,
      this.currentStep,
      this.pressed,
      this.record});

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  onPress(index) {
    widget.nextStep(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Simon Game",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimonButton(
                  bgColor: Colors.lightGreen,
                  onPress: () {
                    onPress(0);
                  },
                  pressed: widget.pressed == 0,
                  canPlay: widget.canPlay,
                ),
                SimonButton(
                  bgColor: Colors.red,
                  onPress: () {
                    onPress(1);
                  },
                  pressed: widget.pressed == 1,
                  canPlay: widget.canPlay,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimonButton(
                  bgColor: Colors.yellow,
                  onPress: () {
                    onPress(2);
                  },
                  pressed: widget.pressed == 2,
                  canPlay: widget.canPlay,
                ),
                SimonButton(
                  bgColor: Colors.blue,
                  onPress: () {
                    onPress(3);
                  },
                  pressed: widget.pressed == 3,
                  canPlay: widget.canPlay,
                ),
              ],
            ),
            Text(
              'Recorde: ${widget.record}',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nível: ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  "${widget.level}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sequência: ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  "${widget.currentStep}/${widget.level}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
