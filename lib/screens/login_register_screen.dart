import 'package:akangatu_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage>
    with SingleTickerProviderStateMixin {
  final loginFormKey = GlobalKey<FormState>();
  final loginEmail = TextEditingController();
  final loginSenha = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();
  final registerName = TextEditingController();
  final registerEmail = TextEditingController();
  final registerSenha = TextEditingController();
  final registerConfirmarSenha = TextEditingController();

  bool loading = false;

  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(loginEmail.text, loginSenha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.message,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  registrar() async {
    try {
      setState(() => loading = true);
      await context
          .read<AuthService>()
          .registrar(registerName.text, registerEmail.text, registerSenha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.message,
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            child: Stack(
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
                            offset: Offset(4, 4), // changes position of shadow
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 4,
                            offset:
                                Offset(-4, -4), // changes position of shadow
                          )
                        ]))),
                Container(
                  margin: new EdgeInsets.symmetric(
                      horizontal: 65.0 * fem, vertical: 230.0 * fem),
                  width: 230 * fem,
                  height: 41 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
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
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _tabController,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.white,
                        labelStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            text: 'LOGIN',
                          ),
                          Tab(
                            text: 'REGISTRAR',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.symmetric(
                      horizontal: 60.0 * fem, vertical: 290.0 * fem),
                  width: 290 * fem,
                  height: 539 * fem,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Form(
                        key: loginFormKey,
                        child: ListView(
                          children: [
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: loginEmail,
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
                                  return 'Informe o e-mail!';
                                }
                                return null;
                              },
                            ),
                            Text(''),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: loginSenha,
                              obscureText: true,
                              obscuringCharacter: "•",
                              decoration: const InputDecoration(
                                prefixIconColor: Color(0xFF4A148C),
                                prefixIcon: Icon(Icons.lock_open_outlined),
                                hintText: 'Senha',
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
                                  return 'Informe sua senha!';
                                }
                                return null;
                              },
                            ),
                            Container(
                              margin: new EdgeInsets.symmetric(
                                  vertical: 60.0, horizontal: 30.0),
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
                              width: 30 * fem,
                              height: 50 * fem,
                              child: (loading)
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 93),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: BorderSide(
                                                      color: Colors
                                                          .transparent)))),
                                      onPressed: () {
                                        if (loginFormKey.currentState!
                                            .validate()) {
                                          login();
                                        }
                                      },
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: registerFormKey,
                        child: ListView(
                          padding: EdgeInsets.all(12),
                          children: [
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: registerName,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_2_outlined),
                                prefixIconColor: Color(0xFF4A148C),
                                hintText: 'Usuário',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    fontWeight: FontWeight.bold),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF4A148C),
                                  width: 2,
                                )),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'O nome deve ser preenchido.';
                                }
                                return null;
                              },
                            ),
                            Text(''),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: registerEmail,
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
                            Text(''),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: registerSenha,
                              obscureText: true,
                              obscuringCharacter: "•",
                              decoration: const InputDecoration(
                                prefixIconColor: Color(0xFF4A148C),
                                prefixIcon: Icon(Icons.lock_outline_rounded),
                                hintText: 'Senha',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    fontWeight: FontWeight.bold),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF4A148C),
                                  width: 2,
                                )),
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
                            Text(''),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: registerConfirmarSenha,
                              obscureText: true,
                              obscuringCharacter: "•",
                              decoration: const InputDecoration(
                                prefixIconColor: Color(0xFF4A148C),
                                prefixIcon: Icon(Icons.lock_open_outlined),
                                hintText: 'Confirmar senha',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    fontWeight: FontWeight.bold),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF4A148C),
                                  width: 2,
                                )),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'A senha deve ser confirmada.';
                                } else if (value != registerSenha.text) {
                                  return 'As senhas devem ser iguais!';
                                }
                                return null;
                              },
                            ),
                            Container(
                              margin: new EdgeInsets.symmetric(
                                  vertical: 60.0, horizontal: 30.0),
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
                              width: 149 * fem,
                              height: 50 * fem,
                              child: (loading)
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 81),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: BorderSide(
                                                      color: Colors
                                                          .transparent)))),
                                      onPressed: () {
                                        if (registerFormKey.currentState!
                                            .validate()) {
                                          registrar();
                                        }
                                      },
                                      child: Text(
                                        'REGISTRAR',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
