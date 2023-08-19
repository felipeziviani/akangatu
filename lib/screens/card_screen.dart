import 'package:akangatu_project/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import '../controllers/theme_controller.dart';
import 'package:akangatu_project/screens/card_screen.dart';
import 'package:akangatu_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart'; 
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
        child: Drawer(child: MenuPage()),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          SizedBox(height: 50,),
          Container(
          width: 325,
          height: 200,
          decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 5.0,
            style: BorderStyle.solid
          ),

          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 204, 204, 197)),
          child:SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Column(

                      children: [
                        
                        QuillEditor.basic(controller: _controller, 
                        readOnly: false),
                        QuillToolbar.basic(
                        controller: _controller,
                        toolbarIconSize: 20 ,
                        iconTheme: QuillIconTheme(
                        borderRadius: 14,
                       iconSelectedFillColor: Color.fromARGB(255, 0, 0, 0),
                       iconUnselectedFillColor: Color.fromRGBO(136, 60, 230, 1),
                       iconUnselectedColor: Color.fromARGB(255, 31, 26, 26),
                       iconSelectedColor: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        )

                      ]
                ),
                  ),
                ]
              ),
            ),
          ),
          ),
                      ]
                    ),
        
    );
  }
}  
