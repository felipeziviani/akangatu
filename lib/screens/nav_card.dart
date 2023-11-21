import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../widgets/akanga_app_bar.dart';
import 'menu_screen.dart';

class CardListPage extends StatefulWidget {
  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  var userId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference _collection = FirebaseFirestore.instance.collection('cards_${FirebaseAuth.instance.currentUser!.uid}');

  late Stream<QuerySnapshot> _cardsStream;

  final con = FlipCardController();

  @override
  void initState() {
    super.initState();
    _cardsStream =
        FirebaseFirestore.instance.collection('cards_${userId}').snapshots();
  }

  deleteCard(String documentId) async {
    try {
       await _collection
          .doc(documentId)
          .delete().then((value) => print('foi'))
          .catchError((error) => print('Delete failed $error'));
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: _cardsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum card encontrado.'));
          }

          final cards = snapshot.data!.docs.map((document) {
            final data = document.data() as Map<String, dynamic>;
            final frenteData = data['frente'] as List<dynamic>?;
            String frente = '';

            if (frenteData != null) {
              frenteData.forEach((item) {
                if (item is Map<String, dynamic> && item['insert'] is String) {
                  frente += item['insert'] as String;
                }
              });
            }

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Card()),
                );
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
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 8.0),
                            child: Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GetName(documentId: data['deckId']),
                                    Padding(
                                      padding: EdgeInsets.only(left: 150 * fem),
                                      child: IconButton(
                                        onPressed: () {
                                          deleteCard(document.id);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                          ),
                                        ),
                                        icon: Icon(
                                          size: 20,
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 300 * fem,
                                  child: RichText(
                                    textWidthBasis: TextWidthBasis.longestLine,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.white,
                                        ),
                                        text: '$frente'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // FlipCard(
              //   rotateSide: RotateSide.right,
              //   onTapFlipping: true,
              //   axis: FlipAxis.vertical,
              //   controller: con,
              //   frontWidget: buildCardWidget('Frente', frente),
              //   backWidget: buildCardWidget('Verso', verso),
              // ),
            );
          }).toList();
          return ListView(
            children: cards,
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class GetName extends StatelessWidget {
  var userId = FirebaseAuth.instance.currentUser!.uid;
  final String documentId;
  // late final String name;
  GetName({required this.documentId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('decks_${userId}')
          .doc(documentId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // name = data['name'];
          return Text(
            data['name'],
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
