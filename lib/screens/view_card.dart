import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import '../controllers/theme_controller.dart';
import '../widgets/akanga_app_bar.dart';
import '../widgets/button_view_dialog.dart';
import 'menu_screen.dart';

class ViewCard extends StatelessWidget {
  final Widget deckName;
  final String frente;
  final String verso;
  final con = FlipCardController();

  ViewCard({
    required this.deckName,
    required this.frente,
    required this.verso,
  });

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
        padding: const EdgeInsets.only(left:25, right:25, top: 120),
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
                      padding: EdgeInsets.only(left: 25, top: 25, right: 25),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: deckName)
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
                                  text: frente,
                                  style: TextStyle(
                                    color: Colors.white,
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
                                  child: deckName),
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
                                  text: verso,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: Row(
                children: [
                  SizedBox.fromSize(
                    size: Size(100, 100),
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                             showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ShowGreenDialog();
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'images/icon/DEMAIS_ICONS/feliz.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Lembro",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(100, 100),
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            ShowLateDialog();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'images/icon/DEMAIS_ICONS/relogio.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Adiar",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(100, 100),
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                             showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ShowRedDialog();
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'images/icon/DEMAIS_ICONS/triste.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Não lembro",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
