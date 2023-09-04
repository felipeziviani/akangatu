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

  getDescription ({required String documentId}) {
    return FutureBuilder(
      future: _collection.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return RichText(
            textWidthBasis: TextWidthBasis.longestLine,
            text: TextSpan(
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
              text: '${data['description']}',
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
