import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int progress = 0;
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  String getTime() {
    final int minutes = progress ~/ 60;
    final String seconds = progress.remainder(60).toInt().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Egg timer'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Slider(
            value: progress.toDouble(),
            min: 0,
            max: 600,
            onChanged: (double value) {
              setState(() {
                progress = value.toInt();
              });
            },
          ),
          Text(
            getTime(),
          ),
          FlatButton(
            onPressed: () {
              Timer(
                Duration(
                  seconds: progress.toInt(),
                ),
                () {
                  print('II GATA oul!!!');
                },
              );

              Timer.periodic(
                const Duration(seconds: 1),
                (Timer timer) {
                  setState(() {
                    progress = max(progress - 1, 0);
                  });

                  if (progress == 0) {
                    print('II GATA OUL!!!');
                    timer.cancel();
                    assetsAudioPlayer
                      ..open('res/qsound.mp3')
                      ..play();
                  }
                },
              );
            },
            child: const Text('Start'),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            childAspectRatio: 1.2,
            children: <Widget>[
              RaisedButton(
                color: Colors.brown,
                onPressed: () {
                  setState(
                    () {
                      progress = 240;
                    },
                  );
                },
                padding: const EdgeInsets.all(5.0),
                child: Image.asset('res/4min.bmp'),
              ),
              RaisedButton(
                color: Colors.brown,
                onPressed: () {
                  setState(
                    () {
                      progress = 360;
                    },
                  );
                },
                padding: const EdgeInsets.all(5.0),
                child: Image.asset('res/6min.bmp'),
              ),
              RaisedButton(
                color: Colors.brown,
                onPressed: () {
                  setState(
                    () {
                      progress = 480;
                    },
                  );
                },
                padding: const EdgeInsets.all(5.0),
                child: Image.asset('res/8min.bmp'),
              ),
              RaisedButton(
                color: Colors.brown,
                onPressed: () {
                  setState(
                    () {
                      progress = 600;
                    },
                  );
                },
                padding: const EdgeInsets.all(5.0),
                child: Image.asset('res/10min.bmp'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
