import 'package:akangatu_project/widgets/new_deck_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../screens/create_card_screen.dart';

class NewItemButton extends StatefulWidget {
  const NewItemButton({super.key});

  @override
  State<NewItemButton> createState() => _NewItemButtonState();
}

class _NewItemButtonState extends State<NewItemButton> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return SpeedDial(
      shape: CircleBorder(),
      iconTheme: IconThemeData(size: 30 * fem),
      icon: Icons.add_rounded,
      activeIcon: Icons.close_rounded,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.purple.shade800, Colors.purple.shade900],
      ),
      gradientBoxShape: BoxShape.circle,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.transparent,
      activeForegroundColor: Colors.white,
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      children: [
        SpeedDialChild(
          labelWidget: GestureDetector(
            onTap: () {
              print('DECK COMPARTILHADO');
            },
            child: Container(
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.purple.shade900,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 22.0, right: 5.0),
                    child: Text(
                      'DECK COMPARTILHADO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SpeedDialChild(
          labelWidget: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => CardPage())));
            },
            child: Container(
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.purple.shade900,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 22.0, right: 5.0),
                    child: Text(
                      'ADICIONAR CARD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.add_card_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SpeedDialChild(
          labelWidget: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NewDeckDialog();
                },
              );
            },
            child: Container(
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.purple.shade900,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 22.0, right: 5.0),
                    child: Text(
                      'ADICIONAR DECK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.layers_rounded,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
