import 'package:braille_sih/constants.dart';
import 'package:video_player/video_player.dart';

List<VideoPlayerController> textToSignLanguage(String text){
    List<VideoPlayerController> controllers=[];
    List<int> spaceIndices=[];
    for(int i=0;i<text.length;i++){
      var ch = text[i];
      if(ch==' '){
        spaceIndices.add(i);
      }
    }
    int temp=0;
    List<String> words=[];
    for(int i=0;i<spaceIndices.length;i++){
      words.add(text.substring(temp,spaceIndices[i]));
      temp=spaceIndices[i]+1;
    }
    words.add(text.substring(temp,text.length));
    for(int i=0;i<words.length;i++){
      String word=words[i];
      if(false){
        controllers.add(VideoPlayerController.asset("assets/alphabet_video/${word.toLowerCase()}.mp4"));
      }else{
        for(int j=0;j<word.length;j++){
          controllers.add(VideoPlayerController.asset("assets/AlphabetVideo/${word[j].toUpperCase()}.mp4"));
        }
      }
    }
    return controllers;
}

bool checkIfStatic(String word){
  bool f=false;
  for(int i=0;i<staticWords.length;i++){
    if(staticWords[i]==word){
      f=true;
      break;
    }
  }
  return f;
}