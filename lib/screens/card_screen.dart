import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import '../controllers/theme_controller.dart';
import 'package:akangatu_project/screens/card_screen.dart';
import 'package:akangatu_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
String description = 'My great package';
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
    double fem = MediaQuery.of(context).size.width / baseWidht;
    return Scaffold(
      appBar: AppBar(
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
      ),
      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        child: Drawer(
          child: menuScreen()
        ),
      ),
      drawerScrimColor: ThemeController.instance.isdartTheme ? Color(0xFF2D2D2D) : Colors.white,
      body: Container(
      child: Theme(
        data: ThemeData(
          primaryColor: const Color(0xFF2C1C6B),
          colorScheme: ColorScheme.light().copyWith(secondary: const Color(0xFF200681)),
          cardColor: const Color(0xFFF8F9FC),
          textTheme: const TextTheme(bodyText1: TextStyle(fontSize: 20, color: Color(0xFF2C1C6B))),
        ),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        MarkdownTextInput(
                          (String value) => setState(() => description = value),
                          description,
                          label: 'Description',
                          maxLines: 10,
                          actions: MarkdownType.values,
                          controller: controller,
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.clear();
                          },
                          child: Text('Clear'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: MarkdownBody(
                            data: description,
                            shrinkWrap: true,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
 }
 
    
