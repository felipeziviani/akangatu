import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeckException implements Exception {
  String message;
  DeckException(this.message);
}
CollectionReference _collection = FirebaseFirestore.instance.collection('decks');
class DeckService extends ChangeNotifier {
  
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

  // getDescription ({required String documentId}) async {
  //   return FutureBuilder(
  //     future: _collection.doc(documentId).get(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic> data =
  //             snapshot.data!.data() as Map<String, dynamic>;
  //         return data['description'];
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }
}

class GetDeckDescription extends StatelessWidget {
  final String documentId;

  GetDeckDescription({required this.documentId});

  @override
  Widget build(BuildContext context) {
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

class GetDeckName extends StatelessWidget {
  final String documentId;

  GetDeckName({required this.documentId});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _collection.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['name']}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ));
        }
        return CircularProgressIndicator();
      },
    );
  }
}