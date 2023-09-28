import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CardException implements Exception {
  String message;
  CardException(this.message);
}

  var cardId = FirebaseAuth.instance.currentUser!.uid;
CollectionReference _collection =
    FirebaseFirestore.instance.collection('cards_${cardId}');

class DeckService extends ChangeNotifier {
  bool isLoading = true;

  _getCards() {
    _collection.get();
    notifyListeners();
  }

  newCard(String frente, String verso) async {
    try {
      await _collection.add({
        'Frente': frente,
        'Verso': verso,
      });
      _getCards();
    } on FirebaseException catch (e) {
      if (e.code == '') {
        Exception('');
      } else if (e.code == 'a') {
        Exception('A!');
      }
    }
  }

} 