import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simon_game/src/services/login_service.dart';
import 'package:simon_game/src/utils/alert.dart';
import 'package:simon_game/src/utils/sleep.dart';
import 'background.dart';
import 'board.dart';

class GameBody extends StatefulWidget {
  @override
  _GameBodyState createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  final player = AudioCache(prefix: 'assets/sounds/');
  Random random = Random();
  List<int> sequence = [];
  int level;
  int currentStep;
  int record = 0;
  bool canPlay;
  int pressed;
  bool error;

  @override
  void initState() {
    first();
    super.initState();
  }

  first() async {
    final prefs = await SharedPreferences.getInstance();
    final record = prefs.getInt('record') ?? 0;
    this.record = record;
    await sleep1Sec();
    await sleep1Sec();
    initGame();
  }

  initGame() async {
    setState(() {
      error = false;
      currentStep = 0;
      level = 1;
      sequence = [];
      sequence.add(random.nextInt(4));
      print(sequence);
    });
    await showSequence();
  }

  nextLevel() async {
    setState(() {
      level++;
      currentStep = 0;
      sequence.add(random.nextInt(4));
      print(sequence);
    });

    await showSequence();
  }

  showSequence() async {
    setState(() {
      canPlay = false;
    });
    await sleep1Sec();
    for (var i = 0; i < sequence.length; i++) {
      setState(() {
        pressed = sequence[i];
      });
      playSound(sequence[i]);
      await sleep1Sec();
    }
    setState(() {
      canPlay = true;
      pressed = -1;
    });
  }

  nextStep(int buttonIndex) async {
    playSound(buttonIndex);

    if (sequence[currentStep] == buttonIndex) {
      if (currentStep == sequence.length - 1) {
        nextLevel();
      } else {
        setState(() {
          currentStep++;
        });
      }
    } else {
      setState(() {
        canPlay = false;
      });
      playSound(4);

      if (level > record) {
        final prefs = await SharedPreferences.getInstance();

        postRecord(prefs.getInt('id'), level);

        setState(() {
          record = level;
        });
        gameOverAlert(
            context, 'Parab??ns voc?? conquistou um novo record! N??vel: $level');
        // set value
        prefs.setInt('record', level);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Parab??ns voc?? conquistou um novo record! N??vel: $level'),
          backgroundColor: Colors.green,
        ));
      } else {
        gameOverAlert(context, 'Fim de Jogo, voc?? chegou ao n??vel: $level');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fim de Jogo, voc?? chegou ao n??vel: $level'),
          backgroundColor: Colors.red,
        ));
      }

      await sleep1Sec();
      await sleep1Sec();
      await sleep1Sec();
      await sleep1Sec();
      await sleep1Sec();

      initGame();
    }
  }

  playSound(index) async {
    String color;

    switch (index) {
      case 0:
        color = 'green';
        break;
      case 1:
        color = 'red';
        break;
      case 2:
        color = 'yellow';
        break;
      case 3:
        color = 'blue';
        break;
      case 4:
        color = 'error';
        break;
    }

    await player.play('sound_$color.mp3', mode: PlayerMode.LOW_LATENCY);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Background,
      child: Container(
        padding: EdgeInsets.all(40),
        child: Board(
            nextStep: nextStep,
            level: level.toString(),
            currentStep: currentStep.toString(),
            pressed: pressed,
            canPlay: canPlay,
            record: record.toString()),
      ),
    );
  }
}
