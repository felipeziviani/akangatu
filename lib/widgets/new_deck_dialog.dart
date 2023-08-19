import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewDeckDialog extends StatefulWidget {
  const NewDeckDialog({super.key});

  @override
  State<NewDeckDialog> createState() => _NewDeckDialogState();
}

class _NewDeckDialogState extends State<NewDeckDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      scrollable: true,
      title: Text("DECK",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(24),
                ],
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  // prefixIcon: Icon(Icons.person_2_outlined),
                  // prefixIconColor: Color(0xFF4A148C),
                  hintText: 'Nome',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontWeight: FontWeight.bold),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFF4A148C),
                    width: 2,
                  )),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              TextFormField(
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(64),
                ],
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  //prefixIcon: Icon(Icons.person_2_outlined),
                  //prefixIconColor: Color(0xFF4A148C),
                  hintText: 'Descrição',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontWeight: FontWeight.bold),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFF4A148C),
                    width: 2,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.purple.shade900),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.transparent)))),
              onPressed: () {},
              child: Text(
                'CRIAR DECK',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
