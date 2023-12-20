import 'dart:io';

import 'package:braille_sih/Screen2.dart';
import 'package:braille_sih/generated/l10n.dart';
import 'package:braille_sih/parent_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  FlutterTts flutterTts = FlutterTts();
  VideoPlayerController controller = VideoPlayerController.asset('assets/images/welcome.mp4');

  void SpeakText(String text) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = await prefs.getString("LanguageCode")!;
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(code);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
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

  void changeScreen() async{
    await Future.delayed(Duration(seconds: 7));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ParentStudentScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      SpeakText(S.of(context).welcomeToApp);
      loadVideoPlayer();
      changeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(S.of(context).welcom,style:GoogleFonts.arimo()),
          actions: [
            IconButton(
                onPressed: () async{
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MainScreen()
                    ),
                  );
                },
                icon: Icon(Icons.refresh,color: Colors.black,)
            ),
          ],
        ),
        body: Column(
          children: [
            Center(child: Image(image: AssetImage('assets/images/logo.png'),width: 200,height: 200,)),
            Center(child: Text(S.of(context).intro,style:GoogleFonts.arimo(),)),
            SizedBox(height: 50,),
            Center(child: Container(width: 200,height: 200,child: VideoPlayer(controller)))
          ],
        ),
    );
  }
}
