import 'package:akangatu_project/screens/frente_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'home_screen.dart';

class VersoScreenCard extends StatefulWidget {
  const VersoScreenCard({super.key});

  @override
  State<VersoScreenCard> createState() => _VersoScreenCard();
}

class _VersoScreenCard extends State<VersoScreenCard> {
  QuillController _controller = QuillController.basic();
  late String description;
  TextEditingController controller = TextEditingController();

  bool status = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      print(controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidht = 360;
    // ignore: unused_local_variable
    double fem = MediaQuery.of(context).size.width / baseWidht;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
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
                    image: AssetImage('images/icon/NEON/NeonMinimalist.png'),
                    width: 35 * fem,
                    height: 35 * fem,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
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
                    Text('DECK ATUAL:',
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
                      child: ListView(children: <Widget>[
                        Column(children: [
                          QuillToolbar.basic(
                            multiRowsDisplay: false,
                            showIndent: false,
                            showLeftAlignment: true,
                            controller: _controller,
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
                              controller: _controller, readOnly: false),
                        ])
                      ]),
                    ),
                  ),
                ],
              ),
              frontbtn(),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class frontbtn extends StatelessWidget {
  const frontbtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(_frontbtnRoute());
        },
        child: const Text('FRONT CARD'),
      ),
    );
  }
}

Route _frontbtnRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const CardPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
