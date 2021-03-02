import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  void playSound(int trackNumber) {
    final player = AudioCache();
    player.play('note$trackNumber.wav');
  }

  Widget getFlatButton({Color color, int trackNumber}) {
    return Expanded(
      child: FlatButton(
        color: color,
        onPressed: () {
          playSound(trackNumber);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getFlatButton(color: Colors.red, trackNumber: 1),
              getFlatButton(color: Colors.orange, trackNumber: 2),
              getFlatButton(color: Colors.blue, trackNumber: 3),
              getFlatButton(color: Colors.green, trackNumber: 4),
              getFlatButton(color: Colors.purple, trackNumber: 5),
              getFlatButton(color: Colors.cyan, trackNumber: 6),
              getFlatButton(color: Colors.yellow, trackNumber: 7),
            ],
          ),
        ),
      ),
    );
  }
}
