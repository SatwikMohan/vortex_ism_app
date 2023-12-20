import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:http/http.dart' as http;
class Screen7 extends StatefulWidget {
  const Screen7({Key? key}) : super(key: key);

  @override
  State<Screen7> createState() => _Screen7State();
}

class _Screen7State extends State<Screen7> {

  FlutterTts flutterTts = FlutterTts();
  WhiteBoardController whiteBoardController =WhiteBoardController();
  late Uint8List fileData;
  String writtenText="";


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

        String putbaseUrl="https://braille-70ade-default-rtdb.firebaseio.com/Prototype.json";
        writtenText+=data['class'].toString();
        final body={
          'Data':writtenText
        };
        await http.put(Uri.parse(putbaseUrl),headers: { 'Content-Type':'application/json' },
            body: jsonEncode(body)
        );

      });
    }catch(e){
      print("API Error => "+e.toString());
    }
  }

  int time =0;
  int f=0;
  void setTimer() async{
    for(;time<4;time++){
      print(time);
      await Future.delayed(Duration(seconds: 1));
    }

    if(time==4){
      time=0;
      f=0;
      print('time');
      whiteBoardController.convertToImage();
      await Future.delayed(Duration(seconds: 1));
      whiteBoardController.clear();
    }
  }

  int flag =0;

  void SaveFile() async{
    if(writtenText.length>0){
      await flutterTts.speak("Your file is getting saved");
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      print("File=>>>${file}");
      await file.writeAsString(writtenText);
      Reference reference=FirebaseStorage.instance.ref("MyFolder/").child("my_file.txt");
      await reference.putFile(file).whenComplete(()async{
        await flutterTts.speak("Your file is successfully saved");
        writtenText="";
        flag=0;
      });
    }else{
      await flutterTts.speak("You have not written anything");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startProcess();
  }

  late StreamSubscription<double> _subscription;
  double initVolume =0;
  void startProcess() async{
    if(PerfectVolumeControl.getVolume()==0)
      PerfectVolumeControl.setVolume(0.5);
    if(PerfectVolumeControl.getVolume()==1)
      PerfectVolumeControl.setVolume(0.875);
    initVolume= await PerfectVolumeControl.getVolume();
    _subscription = PerfectVolumeControl.stream.listen((value) {
      print(value);
      if(value>initVolume){
        print("Up");
        writtenText+=" ";
        PerfectVolumeControl.setVolume(initVolume);
      }
      else if(value<initVolume){
        if(flag==0){
          flag=1;
          SaveFile();
        }
        print("Down");
        PerfectVolumeControl.setVolume(initVolume);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Remove listener
    _subscription.cancel();
  }
String p="Typing";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(p),
      ),
      body:Listener(
        onPointerHover: (details){
          print('Hover');
          setState(() {
            p="Hover";
          });

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
