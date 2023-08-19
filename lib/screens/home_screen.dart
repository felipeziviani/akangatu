import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/models/decks_model.dart';
import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:akangatu_project/widgets/new_deck_dialog.dart';
import 'package:akangatu_project/widgets/new_item_button.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool status = false;

  List<Decks> decks = <Decks>[
    Decks(
        false,
        'DECKCARDS FANTASY \n01',
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                        'Lorem ipsum dolor sit amet consectetur\nadipisicing elit. ',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.access_time_filled_rounded,
                          color: Colors.white),
                      SizedBox(width: 3),
                      Text('00/00/0000',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.layers, color: Colors.white),
                      SizedBox(width: 2),
                      Text(
                        'QUANTIDADE',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
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

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
        child: Drawer(child: MenuPage()),
      ),
      drawerScrimColor: ThemeController.instance.isdartTheme
          ? const Color(0xFF2D2D2D)
          : Colors.white,
      body: ListView(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ExpansionPanelList(
                expandIconColor: Colors.white,
                expansionCallback: (index, isExpanded) {
                  setState(() {
                    decks[index].isExpanded = !decks[index].isExpanded;
                  });
                },
                children: decks.map((Decks deck) {
                  return ExpansionPanel(
                    backgroundColor: Colors.purple[900],
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        textColor: Colors.white,
                        title: Text(
                          deck.nome,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      );
                    },
                    isExpanded: deck.isExpanded,
                    body: deck.body,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromHeight(fem * 55),
                backgroundColor: Colors.grey.shade200,
                shadowColor: Colors.black,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewDeckDialog();
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 50,
                    color: Colors.purple.shade900,
                  )
                ],
              ),
            ),
          ),
        )
      ]),
      floatingActionButton: NewItemButton(),
    );
  }
}
