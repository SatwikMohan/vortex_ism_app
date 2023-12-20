import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
class EyeProblemDetection extends StatefulWidget {
  const EyeProblemDetection({Key? key}) : super(key: key);

  @override
  State<EyeProblemDetection> createState() => _EyeProblemDetectionState();
}

class _EyeProblemDetectionState extends State<EyeProblemDetection> {

  List<CameraDescription>? cameras;
  CameraImage? cameraImage;
  CameraController? controller;
  String output="";

  void runModel() async{
    if(cameraImage!=null){
      var predictions = await Tflite.runModelOnFrame(
          bytesList:cameraImage!.planes.map((e){
            return e.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          rotation: 90,
          imageMean: 127.0,
          imageStd: 127.0,
          numResults: 2,
          threshold: 0.1,
          asynch: true
      );
      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  void loadCameras(){
    controller = CameraController(cameras![0], ResolutionPreset.medium);
    controller!.initialize().then((value){
      if(!mounted){
        return;
      }else{
        setState(() {
          controller!.startImageStream((image){
            cameraImage=image;
            runModel();
          });
        });
      }
    });
  }

  void getCameras() async{
    cameras = await availableCameras();
    loadCameras();
  }

  void loadModel() async{
    await Tflite.loadModel(model: "assets/models/model_unquant.tflite",labels: "assets/models/labels.txt");
    getCameras();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      loadModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eye Problem Detection"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.7,
              child: controller!.value.isInitialized?
              AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: CameraPreview(controller!),
              ):Container(),
            ),
          ),
          Text(output,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        ],
      ),
    );
  }
}
