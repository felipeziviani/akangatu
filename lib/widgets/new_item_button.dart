import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      iconTheme: IconThemeData(size: 30*fem),
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
          child: Icon(Icons.accessibility),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: 'First Menu Child',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('FIRST CHILD'),
          onLongPress: () => print('FIRST CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.brush),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          label: 'Second Menu Child',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('SECOND CHILD'),
          onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: 'Third Menu Child',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('THIRD CHILD'),
          onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),

        //add more menu item childs here
      ],
    );
  }
}
