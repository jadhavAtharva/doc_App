import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String id = 'speech_recognition';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceHome(),
    );
  }
}

class VoiceHome extends StatefulWidget {

  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  var d = <String,String>{};
  String resultText ;
  AudioPlayer audio = AudioPlayer();
  int finished = 0;

  @override
  void initState() {
    super.initState();
    Permission.storage.request().isGranted.then((value){
      initSpeechRecognizer();
    });
  }

    playAudio (String name ) async{
    final player = AudioCache();
    audio = await   player.play('$name.mp3');
    return audio;
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

  void record(String keyword) async {

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => d['$keyword'] = speech),
    );
    if (_isAvailable && !_isListening) {
      dynamic result = await _speechRecognition
          .listen(locale: "en_US");
      print(result);

    }
    setState(() {
      finished = finished + 1;
    });
  }

  Future<void> call(String name) async  {
    AudioPlayer sound = await playAudio('$name');
    record('$name');
    sound.onPlayerCompletion.listen((event) {
      sound = playAudio('2');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.cancel),
                  mini: true,
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.cancel().then(
                            (result) => setState(() {
                          _isListening = result;
                          resultText = "";
                        }),
                      );
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.mic),
                  onPressed: () async{
                    await call('1');
                  },
                  backgroundColor: Colors.pink,
                ),
                FloatingActionButton(
                  child: Icon(Icons.stop),
                  mini: true,
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.stop().then(
                            (result) => setState(() => _isListening = result),
                      );
                    },
                ),
                FloatingActionButton(onPressed: (){
                  print(d);
                }),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.cyanAccent[100],
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Text(
                resultText != null ? resultText : '',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 1- Advice
// 2 - Diagnosis
// 3 - Prescription
// 4 - Symptoms