import 'generated/l10n.dart';
import 'package:braille_sih/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class KeyBoardTextToASL extends StatefulWidget {
  const KeyBoardTextToASL({Key? key}) : super(key: key);

  @override
  State<KeyBoardTextToASL> createState() => _KeyBoardTextToASLState();
}

class _KeyBoardTextToASLState extends State<KeyBoardTextToASL> {

  TextEditingController textEditingController=TextEditingController();
  double kDefaultPadding=20.0;

  VideoPlayer? player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(206, 206, 206, 1),
      appBar: AppBar(
        title: Text("Keyboard Text to ASL",style:GoogleFonts.arimo(),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height-100,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 400,
                  height: 540,
                  child: player!=null?player:Container(),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      height: 69,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2, vertical: kDefaultPadding / 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [BoxShadow(blurRadius: 30, offset: Offset(0, 4), color: Color(0xff087949).withOpacity(0.7))]),
                      child: SafeArea(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: textEditingController,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(border: InputBorder.none, hintText: S.of(context).typeMessage),
                                        ),
                                      ),
                                      SizedBox(width: kDefaultPadding / 4),
                                      FloatingActionButton(
                                        backgroundColor: Colors.green,
                                        onPressed: () async{
                                            final controllers = textToSignLanguage(textEditingController.text);
                                            for(int i=0;i<controllers.length;i++){
                                              setState(() {
                                                controllers[i].initialize();
                                                controllers[i].play();
                                                player=VideoPlayer(controllers[i]);
                                              });
                                              await Future.delayed(Duration(seconds: 5));
                                            }
                                        },
                                        child: Icon(Icons.send,color: Colors.white,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
