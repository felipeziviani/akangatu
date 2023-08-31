import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDeckName extends StatelessWidget {
  final String documentId;

  GetDeckName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference _collection =
        FirebaseFirestore.instance.collection('decks');

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
