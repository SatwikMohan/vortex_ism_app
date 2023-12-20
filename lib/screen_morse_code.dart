import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class MorseCodeScreen extends StatefulWidget {

  @override
  State<MorseCodeScreen> createState() => _MorseCodeScreenState();
}

class _MorseCodeScreenState extends State<MorseCodeScreen> {

  TextEditingController _textEditingController = TextEditingController();
  late StreamSubscription<double> _subscription;
  double initVolume =0;
  @override
  void initState() {
    super.initState();
    // Bind listener
    startProcess();
  }

  void startProcess() async{
    PerfectVolumeControl.setVolume(0.5);
    _subscription = PerfectVolumeControl.stream.listen((value) {
      print(value);
      if(value>0.5){
        print("Up");
        //PerfectVolumeControl.setVolume(0.5);
      }
      else{
        print("Down");
        //PerfectVolumeControl.setVolume(0.5);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Remove listener
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
