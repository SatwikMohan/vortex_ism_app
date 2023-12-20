import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:braille_sih/Screen10.dart';
import 'package:braille_sih/Screen7.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
class Screen5 extends StatefulWidget {
  const Screen5({Key? key}) : super(key: key);

  @override
  State<Screen5> createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {

  FlutterTts flutterTts = FlutterTts();
  WhiteBoardController whiteBoardController =WhiteBoardController();
  late Uint8List fileData;

  void giveOptions(String text) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = await prefs.getString("LanguageCode")!;
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(code);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    await flutterTts.speak(text);
  }

  void SpeakLetter(String text) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = await prefs.getString("LanguageCode")!;
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(code);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    await flutterTts.speak(text);
  }

  void SpeakText(String text) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = await prefs.getString("LanguageCode")!;
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(code);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    await flutterTts.speak(text);
    await Future.delayed(Duration(seconds: 6));
    giveOptions('Type A in Braille and wait for few seconds to go to Typing Screen, Type B in Braille and wait for few seconds to convert PDF file to speech');
  }

  void say(String text, Widget wid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = await prefs.getString("LanguageCode")!;
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(code);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    await flutterTts.speak(text).whenComplete((){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => wid));
    });
  }

  void MoveToThatScreen(String text){
    if(text=="A"){
        say("You Chose A, Moving to Typing Screen",Screen7());
    }
    else if(text=="B"){
      say("You Chose B, Moving to Files Screen",Screen10());
    }
  }

  void getEnglishAlphabet(Uint8List list) async {

    try{
      String baseUrl="http://shuvam23dotrec.pythonanywhere.com/predict";//deep learning
      String base64=base64Encode(list);

      Map<String, String> heads = {
        "Content-type": 'application/json',
      };
      var request = http.MultipartRequest("POST", Uri.parse(baseUrl));
      request.headers.addAll(heads);
      request.fields['image']=base64;
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) async {
        print("Response => "+value);
        var data=jsonDecode(value);
        print("Output => "+data['class']);

        SpeakLetter(data['class'].toString());
        MoveToThatScreen(data['class'].toString());

      });
    }catch(e){
      print("API Error => "+e.toString());
    }
  }

  int time =0;
  int f=0;
  void setTimer() async{
   for(;time<5;time++){
     print(time);
     await Future.delayed(Duration(seconds: 1));
   }

   if(time==5){
     time=0;
     f=0;
     print('time');
     whiteBoardController.convertToImage();
     await Future.delayed(Duration(seconds: 3));
     whiteBoardController.clear();
   }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SpeakText("Hello! Slide the phone into the cover you got options to choose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body:Listener(
        onPointerHover: (details){
          print('Hover');
          time =0;
          if(f==0){
            f=1;
            setTimer();
          }
        },
        child: WhiteBoard(
          // background Color of white board
          backgroundColor: Colors.white,
          // Controller for action on whiteboard
          controller: whiteBoardController,
          // Stroke width of freehand
          strokeWidth: 69,
          // Stroke color of freehand
          strokeColor: Colors.black,
          // For Eraser mode
          isErasing: false,
          // Save image
          onConvertImage: (list) async {
            setState(() {
              fileData=list;
              print(fileData.toString());
              getEnglishAlphabet(fileData);
            });
          },
          // Callback common for redo or undo
          onRedoUndo: (t,m){
        
          },
        ),
      ),
    );
  }
}
