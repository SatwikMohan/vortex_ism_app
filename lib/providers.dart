import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:video_player/video_player.dart';

final localProvider = ChangeNotifierProvider<LocaleNotifier>((ref) => LocaleNotifier());
class LocaleNotifier extends ChangeNotifier{
  Locale locale=Locale('en');
  void setLocale(Locale l){
    locale=l;
    notifyListeners();
  }
}

final imagePathProvider = StateProvider<String>((ref) => "");
final imageTextProvider = ChangeNotifierProvider<ImageTextNotifier>((ref) => ImageTextNotifier());
class ImageTextNotifier extends ChangeNotifier{
  String text="";
  VideoPlayerController? controller;
  VideoPlayer? player;
  void runApiRequest(String imageUrl) async{
    String baseUrl ="https://text-extract-instance.cognitiveservices.azure.com/computervision/imageanalysis:analyze?api-version=2023-04-01-preview&features=Read&language=en&gender-neutral-caption=False";
    Map<String, String> heads = {
      "Content-type": 'application/json',
      "Ocp-Apim-Subscription-Key":""
    };
    final dataBody={
      "url":imageUrl
    };
    final response = await http.post(Uri.parse(baseUrl),headers: heads,body: jsonEncode(dataBody));
    final data = jsonDecode(response.body);
    //print(data);
    text= data['readResult']['content'].toString();
    print(data['readResult']['content']);

    //text="EFGL";//don't forget to comment out
    print(text);
    notifyListeners();
    runPlayer();
  }
  void setText(String path) async{
      print("Inside provider");
      File file = File(path);
      Reference reference=FirebaseStorage.instance.ref().child(path);
      final metadata = SettableMetadata(
        contentType: 'image/jpg',
        customMetadata: {'picked-file-path': file.path},
      );
      String url="";
      print("Before Upload");
      await reference.putFile(file,metadata).whenComplete(() async{
        url=await reference.getDownloadURL();
      });
      print("After Upload");
      print(url);
      runApiRequest(url);
  }
  void runPlayer() async{
    for(int i=0;i<text.length;i++){
      var ch = text[i];
      print(ch);
      if(ch == 'A'|| ch=='a'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/A.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch == 'B'|| ch=='b'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/B.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch == 'C'|| ch=='c'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/C.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch == 'D'|| ch=='d'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/D.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch == 'E'|| ch=='e'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/E.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='F'||ch=='f'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/F.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='G'||ch=='g'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/G.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='H'||ch=='h'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/H.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='I'||ch=='i'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/I.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='J'||ch=='j'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/J.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='K'||ch=='k'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/K.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='L'||ch=='l'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/L.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='M'||ch=='m'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/M.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='N'||ch=='n'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/N.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='O'||ch=='o'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/O.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='P'||ch=='p'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/P.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='Q'||ch=='q'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/Q.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='R'||ch=='r'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/R.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='S'||ch=='s'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/S.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='T'||ch=='t'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/T.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='U'||ch=='u'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/U.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='V'||ch=='v'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/V.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='W'||ch=='w'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/W.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='X'||ch=='x'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/X.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='Y'||ch=='y'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/Y.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else if(ch=='Z'||ch=='z'){
        controller=VideoPlayerController.asset("assets/AlphabetVideo/Z.mp4");
        controller!.initialize();
        controller!.play();
        player=VideoPlayer(controller!);
      }
      else{
        controller=null;
      }
      //await Future.delayed(Duration(seconds: 2,milliseconds: 500));
      notifyListeners();
      await Future.delayed(Duration(seconds: 5));
      // if(ch == 'E'|| ch=='e'){
      //   controller=VideoPlayerController.asset("assets/alphabet_video/E_Reverse.mp4");
      //   controller!.initialize();
      //   controller!.play();
      //   player=VideoPlayer(controller!);
      // }
      // else if(ch=='F'||ch=='f'){
      //   controller=VideoPlayerController.asset("assets/alphabet_video/F_Reverse.mp4");
      //   controller!.initialize();
      //   controller!.play();
      //   player=VideoPlayer(controller!);
      // }
      // else if(ch=='G'||ch=='g'){
      //   controller=VideoPlayerController.asset("assets/alphabet_video/G_Reverse.mp4");
      //   controller!.initialize();
      //   controller!.play();
      //   player=VideoPlayer(controller!);
      // }
      // else if(ch=='H'||ch=='h'){
      //   controller=VideoPlayerController.asset("assets/alphabet_video/H_Reverse.mp4");
      //   controller!.initialize();
      //   controller!.play();
      //   player=VideoPlayer(controller!);
      // }
      // else if(ch=='L'||ch=='l'){
      //   controller=VideoPlayerController.asset("assets/alphabet_video/L_Reverse.mp4");
      //   controller!.initialize();
      //   controller!.play();
      //   player=VideoPlayer(controller!);
      // }
      // else{
      //   controller=null;
      // }
      // //await Future.delayed(Duration(seconds: 2,milliseconds: 500));
      // notifyListeners();
      // await Future.delayed(Duration(seconds: 2));
    }
  }
}
