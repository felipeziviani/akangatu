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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    Text('DECK ATUAL:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              Divider(
                color: Color.fromRGBO(106, 27, 154, 1),
                thickness: 3,
                indent: 40,
                endIndent: 35,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //   Swiper(
                  //   itemWidth: 400,
                  //   itemHeight: 225,
                  //   loop: true,
                  //   duration: 1200,
                  //   scrollDirection: Axis.vertical, //direção de deslizar
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       width: 400,
                  //       height: 400,
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: Color.fromARGB(255, 255, 0, 0)),
                  //       ),
                  //       // BoxDecoration(
                  //       //image: DecorationImage(image: AssetImage(imagepath[index])),
                  //       // borderRadius: BorderRadius.circular(20),
                  //       //),
                  //     );
                  //   },
                  //   itemCount: 2,
                  // ),
                  Container(
                    width: 330,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(235, 235, 235, 235),
                            width: 10.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(234, 255, 255, 255)),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: ListView(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(children: [
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
                            ]),
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
              frontbtn(),
            ],
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
        child: const Text('VERSO CARD'),
      ),
    );
  }
}

Route _frontbtnRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const VersoScreenCard(),
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