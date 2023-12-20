import 'package:braille_sih/progress_class.dart';
import 'package:braille_sih/teach_screen_blind.dart';
import 'package:braille_sih/teach_screen_deaf.dart';
import 'package:braille_sih/web_scrapping.dart';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
class ParentScreen extends StatelessWidget {
  const ParentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).chooseYourChildImpairment,),
        actions: [
          IconButton(
              onPressed: () async{
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => WebScrapping()
                  ),
                );
              },
              icon: Icon(Icons.web,color: Colors.black,)
          ),
          IconButton(
              onPressed: () async{
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ProgressClass()
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeachScreenBlind()));
                },
                    child: Image(image: AssetImage("assets/images/blind.png"))
                ),
              ),
            ),
          ),
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeachScreenDeaf()));
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

