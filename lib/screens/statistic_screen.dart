import 'package:flutter/material.dart';
import '../controllers/theme_controller.dart';
import '../widgets/akanga_app_bar.dart';
import 'menu_screen.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(),
    );
  }
}
