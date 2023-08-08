import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
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
        body: Row(
          children: [
                    Container(
              color: Colors.white,
              child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                        child: Column(
                          children: [
                            Stack(children: <Widget>[
                      Container(
                              width: 360 * fem,
                              height: 370 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromRGBO(74, 20, 140, 1),
                                    Color.fromRGBO(5, 1, 10, 1),
                                  ],
                                )),
                              )),
                      Container(
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 35.0 * fem, vertical: 150.0 * fem),
                              width: 290 * fem,
                              height: 539 * fem,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 5,
                                      blurRadius: 4,
                                      offset:
                                          Offset(4, 4), // changes position of shadow
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 5,
                                      blurRadius: 4,
                                      offset:
                                          Offset(-4, -4), // changes position of shadow
                                    )
                                  ])))
                    ]),
                          ],
                        )))),
                  ],
        ));
  }
}
