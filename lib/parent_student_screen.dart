import 'package:braille_sih/Screen2.dart';
import 'package:braille_sih/parent_screen.dart';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';
class ParentStudentScreen extends StatelessWidget {
  const ParentStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Choose),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ParentScreen()));
                  },
                      child: Image(image: AssetImage("assets/images/parent_image.jpg"))
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Screen2()));
                  },
                      child: Image(image: AssetImage("assets/images/workplace.jpg"))
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
