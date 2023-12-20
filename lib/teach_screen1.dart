import 'package:braille_sih/teach_screen_blind.dart';
import 'package:braille_sih/teach_screen_deaf.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TeachScreen1 extends StatefulWidget {
  const TeachScreen1({Key? key}) : super(key: key);

  @override
  State<TeachScreen1> createState() => _TeachScreen1State();
}

class _TeachScreen1State extends State<TeachScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose",style:GoogleFonts.arimo()),
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
