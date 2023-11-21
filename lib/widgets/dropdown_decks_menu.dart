import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DecksDropdownMenu extends StatefulWidget {
  const DecksDropdownMenu({super.key, required this.callback});

  final Function callback;

  @override
  State<DecksDropdownMenu> createState() => _DecksDropdownMenuState();
}

class _DecksDropdownMenuState extends State<DecksDropdownMenu> {
  var userId = FirebaseAuth.instance.currentUser!.uid;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('decks_$userId').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('ERRO PELO AMOR DE DEUS ${snapshot.error}'),
          );
        }
        List<DropdownMenuItem> allDecks = [];
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          final selectDeck = snapshot.data?.docs.reversed.toList();
          if (selectDeck != null) {
            for (var deck in selectDeck) {
              allDecks.add(DropdownMenuItem(
                value: deck.id,
                child: Text(
                  deck['name'],
                ),
              ));
            }
          }
        }
        return Container(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonFormField(
            iconEnabledColor: Colors.deepPurple.shade800,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              prefixIcon: Icon(
                Icons.layers_rounded,
                color: Colors.deepPurple.shade800,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
            isExpanded: false,
            hint: const Text(
              'SELECIONE O DECK',
              style: TextStyle(color: Colors.grey),
            ),
            value: selectedValue,
            items: allDecks,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                widget.callback(selectedValue);
              });
            },
          ),
        );
      },
    );
  }
}
