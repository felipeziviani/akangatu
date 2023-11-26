import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/screens/home_screen.dart';
import 'package:akangatu_project/screens/nav_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'login_register_screen.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

final MaterialStateProperty<Icon?> thumbIcon =
    MaterialStateProperty.resolveWith<Icon?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.nightlight_round, color: Colors.white);
    }
    return const Icon(Icons.wb_sunny_rounded, color: Colors.white);
  },
);

class _MenuPage extends State<MenuPage> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        body: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          child: Container(
            width: fem * 280,
            child: Container(
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
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 24),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'AKANGÁ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'A chave da memorização',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.home_rounded, color: Colors.white),
                    title: const Text(
                      "HOME",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                  ),
                  ListTile(
                    hoverColor: Colors.white,
                    leading: const Icon(Icons.edit, color: Colors.white),
                    title: const Text(
                      "EDITAR PERFIL",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfilePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.search_sharp, color: Colors.white),
                    title: const Text(
                      "NAVEGAR POR CARDS",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardListPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.white),
                    title: const Text(
                      "AJUDA",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      print('Caminho selecionada: ajuda');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: const Text(
                      "SAIR",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => LoginRegisterPage())));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 350, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Switch(
                          value: ThemeController.instance.isdartTheme,
                          thumbIcon: thumbIcon,
                          inactiveThumbColor: Colors.purple.shade900,
                          inactiveTrackColor:
                              Colors.purple.shade900.withOpacity(0.10),
                          activeColor: Colors.purple.shade900,
                          onChanged: (bool value) {
                            ThemeController.instance.changeTheme();
                          },
                          trackOutlineColor: MaterialStateProperty.resolveWith(
                            (final Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return null;
                              }
                              return Colors.purple.shade900;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
