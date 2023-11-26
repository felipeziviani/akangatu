import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:akangatu_project/services/deck_service.dart';
import 'package:akangatu_project/widgets/akanga_app_bar.dart';
import 'package:akangatu_project/widgets/edit_deck_dialog.dart';
import 'package:akangatu_project/widgets/new_item_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool status = false;
  List<String> docIds = [];

  var userId = FirebaseAuth.instance.currentUser!.uid;
  
  Future getDocId() async {
    docIds.clear();
    await FirebaseFirestore.instance.collection('decks_$userId').get().then(
          (snapshot) { 
            snapshot.docs.forEach(
              (document) {
                docIds.add(document.reference.id);
              },
            );
          }
        );
  }

  late ListView List_Deck;
  @override
  Widget build(BuildContext context) {    
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
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const ListCard()),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        color: Colors.purple[900],
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: Column(
                            children: [
                              ListTile(
                                trailing: IconButton(
                                  icon: Icon(Icons.settings),
                                  color: Colors.white,
                                  iconSize: 24,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EditDeckDialog(
                                            documentId: docIds[index],
                                            data: GetDeckName(documentId: docIds[index]).toString(),
                                            );
                                      },
                                    );
                                  },
                                ),
                                textColor: Colors.white,
                                title: GetDeckName(documentId: docIds[index]),
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
                                      GetDeckDate(documentId: docIds[index]),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.layers, color: Colors.white),
                                      SizedBox(width: 2),
                                      GetCountCards(deckId: docIds[index]),
                                      // GetCountCards(deckId: docIds[index]),
                                      // Text(
                                      //   'QUANTIDADE',
                                      //   style: TextStyle(
                                      //     fontSize: 18,
                                      //     color: Colors.white,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
