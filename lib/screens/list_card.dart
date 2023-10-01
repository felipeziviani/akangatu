import 'package:akangatu_project/screens/view_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controllers/theme_controller.dart';
import '../widgets/akanga_app_bar.dart';
import 'menu_screen.dart';

class ListCard extends StatefulWidget {
  const ListCard({super.key});

  @override
  State<ListCard> createState() => _ListCard();
}

class _ListCard extends State<ListCard> {
  bool status = false;
  List<String> docIds = [];

  var userId = FirebaseAuth.instance.currentUser!.uid;

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
        builder: (context, Index) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewCard()),
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
                                      Text('FERNANDIN',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(left: 150 * fem),
                                        child: IconButton(
                                          onPressed: () {
                                            print('era para deletar a merda do card, mas ele nem existe.');
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
                                          text:
                                              'Amo como ama o amor.  Não conheço nenhuma outra razão para amar senão amar.  Que queres que te diga, além de que te amo, se o que quero dizer-te é que te amo?'),
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
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(50)
     ),
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Colors.purple.shade800, Colors.purple.shade900])),
        ),
      ),
    );
  }
}
