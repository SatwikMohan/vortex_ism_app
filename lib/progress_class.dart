import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class ProgressClass extends StatefulWidget {

  @override
  State<ProgressClass> createState() => _ProgressClassState();
}

class _ProgressClassState extends State<ProgressClass> {

  List<ProgressListModel> progress = [];

  void loadProgressData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = await prefs.getStringList("Progress");
    if(data!=null){
      for(int i=0;i<data.length;i++){
        final map = jsonDecode(data[i]);
        print(map);
        map.forEach((key,value){
          DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(key));
          List<DataModel> dataModel = [];
          final dataMap = jsonDecode(value);
          print(dataMap);
          dataMap.forEach((k,v){
            dataModel.add(DataModel(y: v, x: k));
          });
          setState(() {
            progress.add(ProgressListModel(date: date, dataModel: dataModel));
          });
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProgressData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(itemCount: progress.length,itemBuilder: (context,index){
        List<DataModel> dataModels = progress[index].dataModel;
        return ListTile(
          title: Text(progress[index].date.toString()),
          subtitle: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              series: <CartesianSeries>[
                LineSeries<DataModel,String>
                  (dataSource: dataModels,
                    xValueMapper: (DataModel dataModel,_)=>dataModel.x,
                    yValueMapper: (DataModel dataModel,_)=>dataModel.y
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ProgressListModel{
  late DateTime date;
  late List<DataModel> dataModel;
  ProgressListModel({required this.date,required this.dataModel});
}

class DataModel{
  late int y;
  late String x;
  DataModel({required this.y,required this.x});
}
