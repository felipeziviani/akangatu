import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class menuScreen extends StatefulWidget {
  const menuScreen({super.key});

  @override
  State<menuScreen> createState() => _menuScreen();
}

class _menuScreen extends State<menuScreen> {
  bool hover = true;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
       body: Container(
        width: fem * 280,
        child: Container(
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
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                  children: <Widget>[
                    Text('AKANGÁ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text('A chave da memorização',
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                  ],
                ),
              ),
              ListTile(
                hoverColor: Colors.white,
                leading: const Icon(Icons.edit, color: Colors.white),
                title: const Text("EDITAR PERFIL",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                },
              ),
              ListTile(
                leading: const Icon(Icons.layers, color: Colors.white),
                title: const Text("DECKS DE CARDS",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  print('Caminho selecionada: decks de cards');
                },
              ),
              ListTile(
                leading: const Icon(Icons.search_sharp, color: Colors.white),
                title: const Text("NAVEGAR POR CARDS",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  print('Caminho selecionada: navegar por cards');
                },
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart_rounded, color: Colors.white),
                title: const Text("ESTATÍSTICAS",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  print('Caminho selecionada: estatísticas');
                },
              ),
              ListTile(
                leading: const Icon(Icons.app_settings_alt, color: Colors.white),
                title: const Text("CONFIGURAÇÕES",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  print('Caminho selecionada: configurações');
                },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.white),
                title: const Text("AJUDA",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  print('Caminho selecionada: ajuda');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text("SAIR",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  context.read<AuthService>().logout();
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 250, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    
                    FlutterSwitch(
                      width: 60.0,
                      height: 35.0,
                      toggleSize: 25.0,
                      value: ThemeController.instance.isdartTheme,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: Color(0xFF6E40C9),
                      inactiveToggleColor: Color(0xFF6E40C9),
                      activeSwitchBorder: Border.all(
                        color: Color(0xFF3C1E70),
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: Color(0xFF3C1E70),
                      ),
                      activeColor: Color(0xFF271052),
                      inactiveColor: Color(0xFF271052),
                      activeIcon: Icon(
                        Icons.nightlight_round,
                        color: Colors.white,
                      ),
                      inactiveIcon: Icon(
                        Icons.wb_sunny,
                        color: Colors.white,
                      ), onToggle: (value) { 
                        ThemeController.instance.changeTheme();
                       },
            
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
