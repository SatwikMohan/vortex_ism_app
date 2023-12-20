import 'package:braille_sih/keyboard_text_to_asl.dart';
import 'package:flutter/material.dart';
class TeachScreenDeaf extends StatefulWidget {
  const TeachScreenDeaf({Key? key}) : super(key: key);

  @override
  State<TeachScreenDeaf> createState() => _TeachScreenDeafState();
}

class _TeachScreenDeafState extends State<TeachScreenDeaf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: [
          IconButton(
              onPressed: () async{
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => KeyBoardTextToASL()
                  ),
                );
              },
              icon: Icon(Icons.keyboard,color: Colors.black,)
          ),
        ],
      ),
    );
  }
}
