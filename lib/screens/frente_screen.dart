import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:akangatu_project/screens/verso_screen.dart';
import 'package:akangatu_project/widgets/akanga_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class CardPage extends StatefulWidget {
  const CardPage({super.key});
  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  QuillController _controller = QuillController.basic();
  late String description;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      print(controller.text);
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
        body: Column(
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
            SizedBox(
              height: 30,
            ),
            VersoScreenCard()
          ],
        ),
      ),
    );
  }
}

// class frontbtn extends StatelessWidget {
//   const frontbtn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 50),
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).push(_frontbtnRoute());
//         },
//         child: const Text('VERSO CARD'),
//       ),
//     );
//   }
// }

// Route _frontbtnRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>
//         const VersoScreenCard(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
