import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:akangatu_project/widgets/akanga_app_bar.dart';
import 'package:akangatu_project/widgets/dropdown_decks_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../controllers/theme_controller.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});
  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  bool status = false;
  bool loading = false;
  late String deckId;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final cardFormKey = GlobalKey<FormState>();
  final QuillController controllerfrente = QuillController.basic();
  late String descriptiontextfrente;
  final QuillController controllerverso = QuillController.basic();
  late String descriptiontextverso;

  List quillToJSON(QuillController controllerfrente) {
    final Delta delta = controllerfrente.document.toDelta();
    return delta.toJson();
  }

  @override
  void initState() {
    super.initState();

    controllerfrente.addListener(() {
      print(controllerfrente.document.toPlainText());
    });

    controllerverso.addListener(() {
      print(controllerverso.document.toPlainText());
    });
  }

  salvarCard(String frente, String verso, context, String idDeck) async {
    setState(() => loading = true);
    try {
      // ignore: unused_local_variable
      final cardData = {
        'deckId': idDeck,
        'frente': quillToJSON(controllerfrente),
        'verso': quillToJSON(controllerverso),
      };
      await FirebaseFirestore.instance
          .collection('cards_${userId}')
          .add(cardData);
    } on Exception catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            e.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  void callbackDeck(String selectedValue) {
    setState(() {
      deckId = selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidht = 360;
    double fem = MediaQuery.of(context).size.width / baseWidht;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AkangaAppBar(),
        drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          child: Drawer(child: MenuPage()),
        ),
        drawerScrimColor: ThemeController.instance.isdartTheme
          ? const Color(0xFF2D2D2D)
          : Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: cardFormKey,
            child: Column(
              children: [
                DecksDropdownMenu(callback: callbackDeck),
                Divider(
                  height: 25,
                  color: Colors.transparent,
                ),
                Container(
                  width: 330,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(235, 235, 235, 235),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'FRENTE CARD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 115, 32, 215),
                        // backgroundColor:Color.fromARGB(235, 235, 235, 235)
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(235, 235, 235, 235),
                          width: 10.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.zero,
                        topLeft: Radius.zero,
                      ),
                      color: Color.fromARGB(234, 255, 255, 255)),
                  child: SafeArea(
                    child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Column(children: [
                            QuillToolbar.basic(
                              multiRowsDisplay: false,
                              showIndent: false,
                              showLeftAlignment: true,
                              controller: controllerfrente,
                              toolbarIconSize: 17,
                              iconTheme: QuillIconTheme(
                                borderRadius: 4,
                                iconSelectedFillColor: Colors.purple.shade900,
                                iconUnselectedFillColor:
                                    Color.fromRGBO(255, 255, 255, 1),
                                iconUnselectedColor:
                                    Color.fromARGB(255, 31, 26, 26),
                                iconSelectedColor:
                                    Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                            QuillEditor.basic(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                controller: controllerfrente,
                                readOnly: false),
                          ])
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 330,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(235, 235, 235, 235),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'VERSO CARD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 115, 32, 215),
                        // backgroundColor:Color.fromARGB(235, 235, 235, 235)
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(235, 235, 235, 235),
                          width: 10.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.zero,
                        topLeft: Radius.zero,
                      ),
                      color: Color.fromARGB(234, 255, 255, 255)),
                  child: SafeArea(
                    child: ListView(children: <Widget>[
                      Column(children: [
                        QuillToolbar.basic(
                          multiRowsDisplay: false,
                          showIndent: false,
                          showLeftAlignment: true,
                          controller: controllerverso,
                          toolbarIconSize: 17,
                          iconTheme: QuillIconTheme(
                            borderRadius: 4,
                            iconSelectedFillColor: Colors.purple.shade900,
                            iconUnselectedFillColor:
                                Color.fromRGBO(255, 255, 255, 1),
                            iconUnselectedColor:
                                Color.fromARGB(255, 31, 26, 26),
                            iconSelectedColor:
                                Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                        QuillEditor.basic(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            controller: controllerverso,
                            readOnly: false),
                      ])
                    ]),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.symmetric(
                      vertical: 27.0, horizontal: 60.0),
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
                  width: 120 * fem,
                  height: 50 * fem,
                  child: (loading)
                      ? Padding(
                      padding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: 93),
                      child: CircularProgressIndicator(),
                      )
                      :
                      ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                    onPressed: () {
                      salvarCard(
                          controllerfrente.document.toPlainText(),
                          controllerverso.document.toPlainText(),
                          context,
                          deckId);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CardPage(); // Substitua 'SuaPaginaAtual' pelo nome da sua página atual
                        },
                      ));
                    },
                    child: Text(
                      'SALVAR',
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
        ),
      ),
    );
  }
}
