import 'package:braille_sih/Screen4.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class DeafOptionScreen extends StatefulWidget {

  @override
  State<DeafOptionScreen> createState() => _DeafOptionScreenState();
}

class _DeafOptionScreenState extends State<DeafOptionScreen> {
  VideoPlayerController controller = VideoPlayerController.asset('assets/images/deaf_options.mp4');
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
    loadVideoPlayer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
     body: Column(
       children: [
         Center(child: Container(width: 200,height: 300,child: VideoPlayer(controller))),
         Padding(
           padding: const EdgeInsets.all(14.0),
           child: Center(
             child:Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                       onPressed: (){
                         Navigator.of(context).push(
                           MaterialPageRoute(
                               builder: (context) => Screen4(),
                           ),
                         );
                       },
                       child: Image(image: AssetImage("assets/AlphabetSign/A.jpg"),width: 100,height: 100,)
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                       onPressed: (){

                       },
                       child: Image(image: AssetImage("assets/AlphabetSign/B.jpg"),width: 100,height: 100,)
                   ),
                 ),
               ],
             ) ,
           ),
         )
       ],
     ),
    );
  }
}
