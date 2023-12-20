import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class Screen10 extends StatefulWidget {

  @override
  State<Screen10> createState() => _Screen10State();
}

class _Screen10State extends State<Screen10> {

  FlutterTts flutterTts = FlutterTts();

  void speakFile(String text) async{
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

  void SpeakText(String text) async{
    List<dynamic> languages = await flutterTts.getLanguages;
    print("Languages => "+languages.toString());
    await flutterTts.setLanguage(Platform.localeName.substring(0,2));
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    await flutterTts.speak(text).then((value){
      ff=0;
      f=0;
    });
  }

  int f=0;
  int ff=0;
  Reference? _reference;

  void loadFiles() async{
    Reference reference = FirebaseStorage.instance.ref("MyFolder/");
    ListResult result = await reference.listAll();
    for(Reference element in result.items){
      if(f==0){
        print(element.name);
        _reference=element;
        speakFile(element.name);
        await Future.delayed(Duration(seconds: 5));
      }
    }
    // result.items.forEach((element) async{
    //
    // });
  }

  String text="";

  @override
  void initState() {
    super.initState();
    VolumeProcessing();
    loadFiles();
  }

  void VolumeProcessing()async{
    if(PerfectVolumeControl.getVolume()==0){
      PerfectVolumeControl.setVolume(0.5);
    }
    if(PerfectVolumeControl.getVolume()==1){
      PerfectVolumeControl.setVolume(0.875);
    }
    double initVolume=await PerfectVolumeControl.getVolume();
    PerfectVolumeControl.stream.listen((value) async {
      if(value>initVolume){
        if(ff==0){
          ff=1;
          print("Up");
          f=1;
          Directory appDocDir = await getApplicationDocumentsDirectory();
          File downloadToFile = File('${appDocDir.path}/downloaded.txt');
          await _reference!.writeToFile(downloadToFile);
          String p=downloadToFile.readAsStringSync().toString();
          setState((){
            flutterTts.stop();
            text=p;
            SpeakText(text);
          });
        }
      }
      PerfectVolumeControl.setVolume(initVolume);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              f=0;
              ff=0;
              setState(() {
                text="";
              });
              loadFiles();
              },
                icon: Icon(Icons.refresh)
            ),
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(text,style:GoogleFonts.arimo()),
          ],
        ),
      ),
    );
  }
}
