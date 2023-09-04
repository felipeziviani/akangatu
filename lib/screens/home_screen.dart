import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/models/decks_model.dart';
import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:akangatu_project/services/deck_get_description_service.dart';
import 'package:akangatu_project/services/deck_get_name_service.dart';
import 'package:akangatu_project/services/deck_service.dart';
import 'package:akangatu_project/widgets/akanga_app_bar.dart';
import 'package:akangatu_project/widgets/new_deck_dialog.dart';
import 'package:akangatu_project/widgets/new_item_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool status = false;
  List<String> docIds = [];
  
  Future getDocId() async {
    docIds.clear();
    await FirebaseFirestore.instance.collection('decks').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIds.add(document.reference.id);
            },
          ),
        );
  }

  getDesc(String docId) async {
    await context
          .read<DeckService>()
          .getDescription(documentId: docId);
  }

  List<Decks> decks = <Decks>[Decks(false, '', Container())];

  late ListView List_Deck;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AkangaAppBar(),
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
      body: FutureBuilder(
          future: getDocId(),
          builder: (context, Index) {
            return ListView.builder(
              itemCount: docIds.length,
              itemBuilder: (context, index) {
                return Container(
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
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                textColor: Colors.white,
                                title: GetDeckName(documentId: docIds[index]),
                              );
                            },
                            isExpanded: deck.isExpanded,
                            body: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: 300 * fem,
                                          child: getDesc(docIds[index]),
                                      ),
                                  )],
                                  ),
                                  Divider(
                                    color: Colors.transparent,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(Icons.access_time_filled_rounded,
                                              color: Colors.white),
                                          SizedBox(width: 3),
                                          Text(
                                            '00/00/0000',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.layers,
                                              color: Colors.white),
                                          SizedBox(width: 2),
                                          Text(
                                            'QUANTIDADE',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
      floatingActionButton: NewItemButton(),
    );
  }
}


