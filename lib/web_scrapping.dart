import 'package:braille_sih/educational_news.dart';
import 'package:braille_sih/general_news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'generated/l10n.dart';
class WebScrapping extends StatefulWidget {
  const WebScrapping({Key? key}) : super(key: key);

  @override
  State<WebScrapping> createState() => _WebScrappingState();
}

class _WebScrappingState extends State<WebScrapping> {

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    GeneralNews(),
    EducationalNews()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).news,style: GoogleFonts.arimo(),),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'General News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cast_for_education),
            label: 'Educational News',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
