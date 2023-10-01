import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import '../controllers/theme_controller.dart';
import '../widgets/akanga_app_bar.dart';
import 'menu_screen.dart';

class ViewCard extends StatefulWidget {
  const ViewCard({super.key});

  @override
  State<ViewCard> createState() => _ViewCard();
}

class _ViewCard extends State<ViewCard> {
  final con = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AkangaAppBar(),
      drawer: ClipRRect(
        child: Drawer(child: MenuPage()),
      ),
      drawerScrimColor: ThemeController.instance.isdartTheme
          ? const Color(0xFF2D2D2D)
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            FlipCard(
              rotateSide: RotateSide.right,
              onTapFlipping: true,
              axis: FlipAxis.vertical,
              controller: con,
              frontWidget: Container(
                  width: 300,
                  height: 250,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple.shade900,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, top: 25,right: 25),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'FERNANDIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Amo como ama o amor.  Não conheço nenhuma outra razão para amar senão amar.  Que queres que te diga, além de que te amo, se o que quero dizer-te é que te amo?',
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              backWidget: Container(
                  width: 300,
                  height: 250,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple.shade900,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, top: 25, right: 25),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'FERNANDIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'A frase expressa que, quando se ama alguém sinceramente, não é necessário dizer mais nada além de "te amo" para transmitir todo o sentimento. É uma declaração direta e poderosa de amor.',
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF6A1B9A),
                      Color(0xFF310C60),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.transparent)))),
                  child: Text(
                    'VIRAR CARD',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    // Flip the card programmatically
                    con.flipcard();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
