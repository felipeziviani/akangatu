import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/models/decks_model.dart';
import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool status = false;

  List<Decks> decks = <Decks> [
    Decks(
      false,
      'Example Deck 01',
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text('Example Deck Description 01'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.access_time_filled_rounded),
                    Text('00/00/0000'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.access_time_filled_rounded),
                    Text('00/00/0000'),
                  ],
                ),
              ],
            )
          ],
        ),
      ))
  ];
  
  late ListView List_Deck;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    List_Deck = ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (index, isExpanded) {
              
            },
          ),)
      ],
    );

    return Scaffold(
        appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(74, 20, 140, 1),
                Color.fromRGBO(5, 1, 10, 1),
              ],
            ),
          ),
        ),
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        child: Drawer(
          child: menuScreen()
        ),
      ),
      drawerScrimColor: ThemeController.instance.isdartTheme ? const Color(0xFF2D2D2D) : Colors.white,
      body: List_Deck,
    );
  }
}
