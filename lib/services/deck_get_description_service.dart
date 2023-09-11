import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class GetDeckDescription extends StatelessWidget {
//   final String documentId;

//   GetDeckDescription({required this.documentId});

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference _collection =
//         FirebaseFirestore.instance.collection('decks');
//     return FutureBuilder(
//       future: _collection.doc(documentId).get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           return RichText(
//             textWidthBasis: TextWidthBasis.longestLine,
//             text: TextSpan(
//               style: TextStyle(
//                 fontSize: 19,
//                 color: Colors.white,
//               ),
//               text: '${data['description']}',
//             ),
//           );
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }
