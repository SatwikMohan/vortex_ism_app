import 'dart:io';
import 'package:braille_sih/firebase_options.dart';
import 'package:braille_sih/generated/l10n.dart';
import 'package:braille_sih/home_language.dart';
import 'package:braille_sih/keyboard_text_to_asl.dart';
import 'package:braille_sih/progress_class.dart';
import 'package:braille_sih/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("LanguageCode", "en");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    print("Default->>> "+Platform.localeName.substring(0,2));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('te'),
        Locale('ml'),
        Locale('gu'),
      ],
      //locale: Locale(Platform.localeName.substring(0,2)),//change language code to change language
      locale: ref.watch(localProvider).locale,
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home: HomeLanguage(),//HomeLanguage
    );
  }
}
