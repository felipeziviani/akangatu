import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:akangatu_project/services/card_service.dart';
import 'package:akangatu_project/widgets/akanga_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class CardPage extends StatefulWidget {
  const CardPage({super.key});
  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  QuillController controllerfrente = QuillController.basic();
  late String descriptiontextfrente;
  TextEditingController controllertextfrente = TextEditingController();


  QuillController controllerverso = QuillController.basic();
  late String descriptiontextverso;
  TextEditingController controllertextverso = TextEditingController();
  
  final cardFormKey = GlobalKey<FormState>();
  salvarCard(dataFrente, dataVerso, context) async{   
  try {
        await context.read<CardService>().newCard(dataFrente, dataVerso);
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
  

  @override
  void initState() {
    super.initState();

    controllertextfrente.addListener(() {
      print(controllertextfrente.text);
    });

      controllertextverso.addListener(() {
      print(controllertextverso.text);
    });
  }



  bool status = false;
  @override
  Widget build(BuildContext context) {
    double baseWidht = 360;
    // ignore: unused_local_variable
    double fem = MediaQuery.of(context).size.width / baseWidht;
    return Flexible(
      child: Scaffold(
        appBar: AkangaAppBar(),
        drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          child: Drawer(child: MenuPage()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: cardFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 50.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.layers,
                          color: Colors.purple.shade900,
                        ),
                        SizedBox(width: 3),
                        Text('DECK ATUAL: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(106, 27, 154, 1),
                    thickness: 3,
                    indent: 40,
                    endIndent: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      //bottom: 20.0
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                      iconSelectedFillColor:
                                          Colors.purple.shade900,
                                      iconUnselectedFillColor:
                                          Color.fromRGBO(255, 255, 255, 1),
                                      iconUnselectedColor:
                                          Color.fromARGB(255, 31, 26, 26),
                                      iconSelectedColor:
                                          Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                  QuillEditor.basic(
                                      controller: controllerfrente, readOnly: false),
                                ])
                              ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                children: [
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
                              iconSelectedColor: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          QuillEditor.basic(
                              controller: controllerverso, readOnly: false),
                        ])
                      ]),
                    ),
                  ),
                ],
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
                    child: //(loading)
                       // ? Padding(
                            //padding: EdgeInsets.symmetric(
                               // vertical: 15, horizontal: 93),
                           // child: CircularProgressIndicator(),
                         // )
                        //: 
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                            onPressed: () {
                              salvarCard(controllertextfrente.text, controllertextverso.text, context);
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
      ),
    );
  }
}
