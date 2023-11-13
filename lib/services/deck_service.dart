import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeckException implements Exception {
  String message;
  DeckException(this.message);
}

var userId = FirebaseAuth.instance.currentUser!.uid;
CollectionReference _collection =
    FirebaseFirestore.instance.collection('decks_${userId}');

class DeckService extends ChangeNotifier {
  bool isLoading = true;
  late DateTime dtCriacao;
  late String dtCriacaoFormatted;

  _getDecks() async {
    _collection.get();
    notifyListeners();
  }

  newDeck(String name) async {
    try {
      dtCriacao = DateTime.now();
      dtCriacaoFormatted = DateFormat('dd/MM/yyyy').format(dtCriacao);
      await _collection.add({
        'name': name,
        'dtCriacao': dtCriacaoFormatted,
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

  editDeck(String documentId, newData, BuildContext context) async {
    DocumentReference document = _collection.doc(documentId);
    document.update({
      'name': newData,
    });
  }

  deleteDeck(String documentId, BuildContext context) async {
    _collection
        .doc(documentId)
        .delete()
        .catchError((error) => print('Delete failed $error'));
  }
}

class GetDeckName extends StatelessWidget {
  final String documentId;
  // late final String name;
  GetDeckName({required this.documentId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _collection.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // name = data['name'];
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

class GetDeckDate extends StatelessWidget {
  final String documentId;
  // late final String name;
  GetDeckDate({required this.documentId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _collection.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // name = data['name'];
          return Text('${data['dtCriacao']}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
