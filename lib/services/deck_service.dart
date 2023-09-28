
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeckException implements Exception {
  String message;
  DeckException(this.message);
}

var userId = FirebaseAuth.instance.currentUser!.uid;
CollectionReference _collection =
    FirebaseFirestore.instance.collection('decks_${userId}');

class DeckService extends ChangeNotifier {
  bool isLoading = true;

  _getDecks() async {
    _collection.get();
    notifyListeners();
  }

  DeleteDeck(String documentId, BuildContext context) async {
    // ignore: unused_local_variable
    final collection = FirebaseFirestore.instance
        .collection('decks_${userId}')
        .doc(documentId) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
        // await context.read<HomePage>().getDocId();
  }

  newDeck(String name) async {
    try {
      await _collection.add({
        'name': name,
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
