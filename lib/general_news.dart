import 'dart:convert';

import 'package:braille_sih/example.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class GeneralNews extends StatefulWidget {
  const GeneralNews({Key? key}) : super(key: key);

  @override
  State<GeneralNews> createState() => _GeneralNewsState();
}

class _GeneralNewsState extends State<GeneralNews> {

  List<Model> news = [];

  void loadNews() async{

    try{
      String baseUrl = "https://disability-news-scraper.onrender.com/api/v1/news/general";
      Map<String, String> heads = {
        "Content-type": 'application/json',
      };
      final response = await http.get(Uri.parse(baseUrl),headers: heads);
      final data = jsonDecode(response.body);
      print(data);
      for(int i=0;i<data["news"].length;i++){
        Model model = Model(link: data["news"][i]["link"].toString(),title: data["news"][i]["title"].toString(),image: data["news"][i]["img"].toString(),article: data["news"][i]["article"].toString());
        setState(() {
          news.add(model);
        });
      }
    }catch(e){
      print(e.toString());
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            title: Text(news[index].title,style: GoogleFonts.arimo()),
            leading: Image.network(news[index].image),
            subtitle: Text(news[index].article.length>42?news[index].article.substring(0,42)+"...":news[index].article),
            trailing: IconButton(onPressed: () async{
                await launchUrl(Uri.parse(news[index].link));
            },
                icon: Icon(Icons.forward,color: Colors.black,)
            ),
          ),
        );

      },itemCount: news.length,)
    );
  }
}

class Model{
  late String link;
  late String image;
  late String title;
  late String article;
  Model({
   required this.link,
   required this.title,
   required this.image,
    required this.article
});
}
