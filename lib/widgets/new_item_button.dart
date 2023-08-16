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
          labelBackgroundColor: Colors.purple.shade900,
          child: Icon(Icons.ios_share_rounded, color: Colors.white),
          backgroundColor: Colors.purple.shade900,
          foregroundColor: Colors.white,
          label: 'compartilhar deck',
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          onTap: () => (),
          onLongPress: () => (),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.purple.shade900,
          child: Icon(Icons.add_sharp, color: Colors.white),
          backgroundColor: Colors.purple.shade900,
          foregroundColor: Colors.white,
          label: 'adicionar nota',
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          onTap: () => (),
          onLongPress: () => (),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.purple.shade900,
          child: Icon(Icons.layers, color: Colors.white),
          foregroundColor: Colors.white,
          backgroundColor: Colors.purple.shade900,
          label: 'criar deck',
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          onTap: () => (),
          onLongPress: () => (),
        ),

        //add more menu item childs here
      ],
    );
  }
}
