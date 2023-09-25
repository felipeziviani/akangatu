import 'package:flutter/material.dart';

class Decks {
  bool isExpanded;
  String nome;
  Widget body;

  Decks(this.isExpanded, this.nome, this.body);

  static document(String id) {}
}
