import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeckException implements Exception {
  String message;
  DeckException(this.message);
}

class DeckService extends ChangeNotifier {
  CollectionReference _collection = FirebaseFirestore.instance.collection('decks');
  bool isLoading = true;

  _getDecks() {
    _collection.get();
    notifyListeners();
  }

  newDeck(String name, String description) async {
    try {
      await _collection.add({
        'name': name,
        'description': description,
      });
      _getDecks();
    } on FirebaseException catch (e) {
      if (e.code == '') {
        Exception('');
      } else if (e.code == 'a') {
        Exception('A!');
      }
    }
  }
}
