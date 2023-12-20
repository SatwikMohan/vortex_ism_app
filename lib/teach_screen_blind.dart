import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:http/http.dart' as http;
class TeachScreenBlind extends StatefulWidget {
  const TeachScreenBlind({Key? key}) : super(key: key);

  @override
  State<TeachScreenBlind> createState() => _TeachScreenBlindState();
}

class _TeachScreenBlindState extends State<TeachScreenBlind> {

  FlutterTts flutterTts = FlutterTts();
  WhiteBoardController whiteBoardController =WhiteBoardController();
  late Uint8List fileData;
  List<String> letters=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
  int index=0;
  int attempts=1;
  Map<String,int> map = HashMap();

  void Speak(String text) async{
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(Platform.localeName.substring(0,2));
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    await flutterTts.speak(text);
  }

  void evaluate(String text) async{
    if(text.compareTo(letters[index])==0){
      if(index<=24){//24
        map[text]=attempts;
        index++;
        attempts=1;
        Speak("You wrote it correctly, Now write ${letters[index]}");
      }else{
        //String date = DateTime.now().day.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().year.toString();
        map[text] = attempts;
        String date = DateTime.now().millisecondsSinceEpoch.toString();
        Map<String,String> mp = HashMap();
        //mp[date] = map.toString();
        mp[date]=jsonEncode(map);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if((await prefs.getStringList("Progress"))!=null){
          List<String> list = await prefs.getStringList("Progress")!;
          // list.add(mp.toString());
          list.add(jsonEncode(mp));
          await prefs.setStringList("Progress", list);
        }else{
          await prefs.setStringList("Progress",[jsonEncode(mp)]);
        }
        Speak("Very Good You made it");
      }
    }else{
      attempts++;
      Speak("You wrote it incorrectly, Try Again");
    }
  }

  void SpeakLetter(String text,String l) async{
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(Platform.localeName.substring(0,2));
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    await flutterTts.speak(text).then((value){
      evaluate(l);
    });
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

        SpeakLetter("You wrote the letter "+data['class'].toString(),data['class'].toString());

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
    Speak("Write A");
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
