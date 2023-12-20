// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to Yukta App`
  String get welcomeToApp {
    return Intl.message(
      'Welcome to Yukta App',
      name: 'welcomeToApp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcom {
    return Intl.message(
      'Welcome',
      name: 'welcom',
      desc: '',
      args: [],
    );
  }

  /// `Learning app for specially able`
  String get intro {
    return Intl.message(
      'Learning app for specially able',
      name: 'intro',
      desc: '',
      args: [],
    );
  }

  /// `Live ASL To Text`
  String get liveAsltoText {
    return Intl.message(
      'Live ASL To Text',
      name: 'liveAsltoText',
      desc: '',
      args: [],
    );
  }

  /// `How are you physically impaired? If you are Blind choose the top most present button to continue and if your Deaf choose the bottom most present button to continue`
  String get howImpaired {
    return Intl.message(
      'How are you physically impaired? If you are Blind choose the top most present button to continue and if your Deaf choose the bottom most present button to continue',
      name: 'howImpaired',
      desc: '',
      args: [],
    );
  }

  /// `How are you physically impaired? Please Choose`
  String get chooseImpairment {
    return Intl.message(
      'How are you physically impaired? Please Choose',
      name: 'chooseImpairment',
      desc: '',
      args: [],
    );
  }

  /// `Type A in Braille and wait for few seconds to go to Typing Screen, Type B in Braille and wait for few seconds to convert PDF file to speech`
  String get chooseInBraille {
    return Intl.message(
      'Type A in Braille and wait for few seconds to go to Typing Screen, Type B in Braille and wait for few seconds to convert PDF file to speech',
      name: 'chooseInBraille',
      desc: '',
      args: [],
    );
  }

  /// `You Chose A, Moving to Typing Screen`
  String get youChoose {
    return Intl.message(
      'You Chose A, Moving to Typing Screen',
      name: 'youChoose',
      desc: '',
      args: [],
    );
  }

  /// `Your file is getting saved`
  String get fileSaveUnderProcess {
    return Intl.message(
      'Your file is getting saved',
      name: 'fileSaveUnderProcess',
      desc: '',
      args: [],
    );
  }

  /// `Your file is successfully saved`
  String get fileSaved {
    return Intl.message(
      'Your file is successfully saved',
      name: 'fileSaved',
      desc: '',
      args: [],
    );
  }

  /// `You have not written anything`
  String get notWrittenAnything {
    return Intl.message(
      'You have not written anything',
      name: 'notWrittenAnything',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get Choose {
    return Intl.message(
      'Choose',
      name: 'Choose',
      desc: '',
      args: [],
    );
  }

  /// `Type Message`
  String get typeMessage {
    return Intl.message(
      'Type Message',
      name: 'typeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Child Impairment`
  String get chooseYourChildImpairment {
    return Intl.message(
      'Choose Your Child Impairment',
      name: 'chooseYourChildImpairment',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'gu'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ml'),
      Locale.fromSubtags(languageCode: 'te'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
