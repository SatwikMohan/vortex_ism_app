import 'dart:io';

import 'package:braille_sih/Screen5.dart';
import 'package:braille_sih/deaf_option_screen.dart';
import 'package:braille_sih/eye_problem_detection.dart';
import 'package:braille_sih/teach_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'generated/l10n.dart';
class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {

  FlutterTts flutterTts = FlutterTts();
  VideoPlayerController controller = VideoPlayerController.asset('assets/images/screen2.mp4');

  void SpeakText(String text) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = await prefs.getString("LanguageCode")!;
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(code);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.35);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    await flutterTts.speak(text);
  }

  void loadVideoPlayer(){
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value){
      setState(() {});
    });
    controller.play();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,()
    {
      SpeakText(S.of(context).howImpaired);
      loadVideoPlayer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).chooseImpairment,style:GoogleFonts.arimo(),),
        actions: [
          IconButton(
              onPressed: () async{
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => EyeProblemDetection()
                  ),
                );
              },
              icon: Icon(Icons.remove_red_eye_outlined,color: Colors.black,)
          ),
          IconButton(
              onPressed: () async{
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TeachScreen1()
                  ),
                );
              },
              icon: Icon(Icons.leaderboard,color: Colors.black,)
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(onPressed: (){
                  flutterTts.stop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Screen5()));
                },
                    child: Image(image: AssetImage("assets/images/blind.png"))
                ),
              ),
            ),
          ),
          Center(child: Container(width: 150,height: 150,child: VideoPlayer(controller))),
          //SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(onPressed: (){
                  flutterTts.stop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeafOptionScreen()));
                },
                    child: Image(image: AssetImage("assets/images/deaf.png"))
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
