import 'package:braille_sih/main_screen.dart';
import 'package:braille_sih/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class HomeLanguage extends ConsumerWidget {

  VideoPlayerController controller = VideoPlayerController.asset("assets/images/language_intro.mp4");

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // controller.initialize();
    // controller.play();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).chooseLanguage,style:GoogleFonts.arimo()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: VideoPlayer(controller),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () async{
                ref.watch(localProvider.notifier).setLocale(Locale("en"));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("LanguageCode", "en");
              },
                  child: Text("Change to English",style:GoogleFonts.arimo())
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () async{
                ref.watch(localProvider.notifier).setLocale(Locale("hi"));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("LanguageCode", "hi");
              },
                  child: Text("हिंदी में बदलें",style:GoogleFonts.arimo())
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () async{
                ref.watch(localProvider.notifier).setLocale(Locale("gu"));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("LanguageCode", "gu");
              },
                  child: Text("ગુજરાતીમાં બદલો",style:GoogleFonts.arimo())
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () async{
                ref.watch(localProvider.notifier).setLocale(Locale("ml"));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("LanguageCode", "ml");
              },
                  child: Text("മലയാളത്തിലേക്ക് മാറ്റുക",style:GoogleFonts.arimo())
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () async{
                ref.watch(localProvider.notifier).setLocale(Locale("te"));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("LanguageCode", "te");
              },
                  child: Text("తెలుగులోకి మార్చండి",style:GoogleFonts.arimo())
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
              },
                  child: Text(S.of(context).Continue,style:GoogleFonts.arimo(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.blue
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)
                      )
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
