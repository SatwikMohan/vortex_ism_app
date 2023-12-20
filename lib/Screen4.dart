import 'package:braille_sih/asl_text.dart';
import 'package:braille_sih/keyboard_text_to_asl.dart';
import 'package:braille_sih/providers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
class Screen4 extends ConsumerWidget {

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          IconButton(
              onPressed: () async{
                ref.watch(imageTextProvider.notifier).text="";
                final cameras = await availableCameras();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(cameras.first)
                  ),
                );
              },
              icon: Icon(Icons.camera,color: Colors.black,)
          ),
          IconButton(
              onPressed: () async{
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ASLToText()
                  ),
                );
              },
              icon: Icon(Icons.video_call,color: Colors.black,)
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(ref.watch(imageTextProvider).text,style:GoogleFonts.arimo(),),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Container(
                  height: 550,
                  width: MediaQuery.of(context).size.width,
                  //width: 300,
                  child: ref.watch(imageTextProvider).controller!=null?ref.watch(imageTextProvider).player!:Container(child: Text("Nothing"),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TakePictureScreen extends ConsumerWidget {
  final CameraDescription camera;
  TakePictureScreen(this.camera);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    CameraController _controller = CameraController(camera, ResolutionPreset.medium);
    Future<void> _initializeControllerFuture = _controller.initialize();
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture',style:GoogleFonts.arimo())),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            print("IMAGE PATH =>>>>"+image.path);
            ref.watch(imageTextProvider.notifier).setText(image.path);
            Navigator.of(context).pop();

          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

