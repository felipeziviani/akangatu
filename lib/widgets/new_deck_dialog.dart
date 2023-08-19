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
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return AlertDialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      scrollable: true,
      title: Container(
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6A1B9A),
              Color(0xFF310C60),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "NOVO DECK",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
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
                  prefixIcon: Icon(
                    Icons.layers_rounded,
                    color: Color(0xFF4A148C),
                    size: 24,
                  ),
                  hintText: 'Nome Deck',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontWeight: FontWeight.bold),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4A148C),
                      width: 2,
                    ),
                  ),
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
                  prefixIcon: Icon(
                    Icons.more_rounded,
                    color: Color(0xFF4A148C),
                    size: 20,
                  ),
                  hintText: 'Descrição',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontWeight: FontWeight.bold),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4A148C),
                      width: 2,
                    ),
                  ),
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
            Container(
              margin:
                  new EdgeInsets.only(bottom: 20.0, left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF6A1B9A),
                    Color(0xFF310C60),
                  ],
                ),
              ),
              width: 150 * fem,
              height: 40 * fem,
              child: //(loading)
                  // ? Padding(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 15, horizontal: 93),
                  //     child: CircularProgressIndicator(
                  //       color: Colors.white,
                  //     ),
                  //   )
                  // :
                  ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                onPressed: () {
                  print('AAAAAAA');
                },
                child: Text(
                  'CRIAR DECK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
