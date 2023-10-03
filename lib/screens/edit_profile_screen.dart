import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/screens/home_screen.dart';
import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:akangatu_project/services/auth_service.dart';
import 'package:akangatu_project/widgets/edit_tile_box.dart';
import 'package:akangatu_project/widgets/edit_user_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {

  deleteUser() async {
    try {
      await context.read<AuthService>().deleteUser(context);
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

  editField(String field, IconData icon, String data) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditUserDialog(
            field: field,
            icon: icon,
            data: data,
          );
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        iconTheme: IconThemeData(color: Colors.white),
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email!)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
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
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: new EdgeInsets.symmetric(
                                horizontal: 35.0 * fem, vertical: 150.0 * fem),
                            width: 290 * fem,
                            height: 550 * fem,
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
                                    offset: Offset(4, 4),
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 5,
                                    blurRadius: 4,
                                    offset: Offset(
                                        -4, -4), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 30, 40, 30),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFF6A1B9A),
                                            Color(0xFF310C60),
                                          ],
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "EDITAR PERFIL",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  EditTileBox(
                                    icon: Icons.person_2_outlined,
                                    sectionName: 'Usuário',
                                    text: currentUser.displayName!,
                                    tocFunction: () => editField(
                                        'Nome', Icons.person_2_outlined, currentUser.displayName!),
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.transparent,
                                  ),
                                  EditTileBox(
                                    icon: Icons.email_outlined,
                                    sectionName: 'E-mail',
                                    text: currentUser.email!,
                                    tocFunction: () =>
                                        editField('E-mail', Icons.email_outlined, currentUser.email!),
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.transparent,
                                  ),
                                  EditTileBox(
                                    icon: Icons.lock_outline_rounded,
                                    sectionName: 'Senha',
                                    text: '••••••••••••••••••••••••••••••',
                                    tocFunction: () => editField('Senha', Icons.lock_outline_rounded, '••••••••••••••••'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 30),
                                    child: Container(
                                      width: 50 * fem,
                                      height: 50 * fem,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.red.shade600,
                                            Colors.red.shade900,
                                          ],
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          deleteUser();
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
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 35, bottom: 15),
                                child: Image.asset(
                                  'images/icon/NEON/NeonMinimalist.png',
                                  width: 100 * fem,
                                  height: 100 * fem,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
