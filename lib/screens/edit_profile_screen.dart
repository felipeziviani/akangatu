import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/screens/home_screen.dart';
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

    final editFormKey = GlobalKey<FormState>();
    final editName = TextEditingController();
    final editEmail = TextEditingController();
    final editSenhaAtual = TextEditingController();
    final editSenhaNova = TextEditingController();
    final editConfirmarSenhaNova = TextEditingController();

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
      body: Container(
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
                              offset:
                                  Offset(-4, -4), // changes position of shadow
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
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
                            Form(
                              key: editFormKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: editName,
                                      decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.person_2_outlined),
                                        prefixIconColor: Color(0xFF4A148C),
                                        hintText: 'Usuário',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4A148C),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'O nome deve ser preenchido.';
                                        }
                                        return null;
                                      },
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: editEmail,
                                      decoration: const InputDecoration(
                                        prefixIconColor: Color(0xFF4A148C),
                                        prefixIcon: Icon(Icons.email_outlined),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Color(0xFF4A148C),
                                          width: 2,
                                        )),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'O e-mail deve ser preenchido.';
                                        }
                                        return null;
                                      },
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: editSenhaAtual,
                                      obscureText: true,
                                      obscuringCharacter: "•",
                                      decoration: const InputDecoration(
                                        prefixIconColor: Color(0xFF4A148C),
                                        prefixIcon:
                                            Icon(Icons.lock_outline_rounded),
                                        hintText: 'Senha Atual',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4A148C),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'A senha deve ser preenchida para continuar.';
                                        }
                                        return null;
                                      },
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: editSenhaNova,
                                      obscureText: true,
                                      obscuringCharacter: "•",
                                      decoration: const InputDecoration(
                                        prefixIconColor: Color(0xFF4A148C),
                                        prefixIcon:
                                            Icon(Icons.lock_outline_rounded),
                                        hintText: 'Nova Senha',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4A148C),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'A senha deve ser preenchida.';
                                        } else if (value.length < 6) {
                                          return 'A senha deve ter no mínimo seis caracteres.';
                                        }
                                        return null;
                                      },
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: editConfirmarSenhaNova,
                                      obscureText: true,
                                      obscuringCharacter: "•",
                                      decoration: const InputDecoration(
                                        prefixIconColor: Color(0xFF4A148C),
                                        prefixIcon:
                                            Icon(Icons.lock_open_outlined),
                                        hintText: 'Confirmar senha',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4A148C),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'A senha deve ser confirmada.';
                                        } else if (value !=
                                            editSenhaNova.text) {
                                          return 'As senhas devem ser iguais!';
                                        }
                                        return null;
                                      },
                                    ),
                                    Container(
                                      margin: new EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 30.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFF6A1B9A),
                                            Color(0xFF310C60),
                                          ],
                                        ),
                                      ),
                                      width: 149 * fem,
                                      height: 50 * fem,
                                      child: //(loading)
                                          // ? Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         vertical: 15, horizontal: 81),
                                          //     child: CircularProgressIndicator(
                                          //       color: Colors.white,
                                          //     ),
                                          //   )
                                          // :
                                          ElevatedButton(
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
                                        onPressed: () {
                                          if (editFormKey.currentState!
                                              .validate()) {
                                            print('EDITADO');
                                          }
                                        },
                                        child: Text(
                                          'ATUALIZAR',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
