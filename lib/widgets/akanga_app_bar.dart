import 'package:akangatu_project/screens/home_screen.dart';
import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class AkangaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AkangaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return AppBar(
      // title: IconButton(
      //   icon: Icon(Icons.menu_rounded),
      //   iconSize: 24,
      //   color: Colors.white,
      //   onPressed: () => Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => const MenuPage())),
      // ),
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
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 3),
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: Ink.image(
              image: AssetImage('images/icon/WHITE/WhiteMinimalist.png'),
              width: 40 * fem,
              height: 40 * fem,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
