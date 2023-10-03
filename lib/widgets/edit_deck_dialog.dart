import 'package:akangatu_project/services/deck_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../screens/home_screen.dart';

class EditDeckDialog extends StatefulWidget {
  const EditDeckDialog({Key? key, required this.documentId, required this.data}) : super(key: key);
  final String documentId;
  final String data;

  @override
  State<EditDeckDialog> createState() => _EditDeckDialogState();
}

class _EditDeckDialogState extends State<EditDeckDialog> {
  final deckFormKey = GlobalKey<FormState>();
  late TextEditingController newName = TextEditingController();

  bool loading = false;
  late final FirebaseFirestore db;

  late final Map dataToUpdate = {
    'name': newName.text,
  };

  @override
  void initState() {
    super.initState();
    newName = TextEditingController(
      text: widget.data,
    );
  }

  editDeck(String documentId, String dataToUpdate) async {
    try {
      await context
          .read<DeckService>()
          .editDeck(documentId, dataToUpdate, context);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  deleteDeck(String documentId) async {
    try {
      await context.read<DeckService>().deleteDeck(documentId, context);
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

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
            "EDITAR DECK",
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
          key: deckFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: newName,
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
                // ignore: body_might_complete_normally_nullable
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o nome do Deck!';
                  }
                },
              ),
              Divider(
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:
                  new EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0),
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
              width: 125 * fem,
              height: 40 * fem,
              child: Row(
                children: [
                  (loading)
                      ? Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                          onPressed: () {
                            editDeck(widget.documentId, newName.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: Text(
                            'EDITAR DECK',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                ],
              ),
            ),
            Container(
                width: 40 * fem,
                height: 40 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red.shade600,
                      Colors.red.shade900,
                    ],
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      deleteDeck(widget.documentId);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    });
                  },
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
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
