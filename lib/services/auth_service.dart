import 'dart:convert';
import 'package:akangatu_project/services/deck_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;
  var uid;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String nome, String email, String senha) async {
    String senhaMd5 = md5.convert(utf8.encode(senha)).toString();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: senhaMd5)
          .then((UserCredential userCredential) {
            userCredential.user!.updateDisplayName(nome);
          })
          // ignore: argument_type_not_assignable_to_error_handler
          .catchError((FirebaseAuthException FirebaseAuthException) {})
          .then((value) {
            CollectionReference users =
                FirebaseFirestore.instance.collection('users');
            users.add({
              'nome': nome,
              'email': email,
              'senha': senhaMd5,
            });
          });
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'invalid-email') {
        throw AuthException('O e-mail é invalido!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está sendo usado!');
      }
    }
  }

  login(String email, String senha) async {
    String senhaMd5 = md5.convert(utf8.encode(senha)).toString();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senhaMd5);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(
            'Não há usuário cadastrado com este e-mail. Cadastre-se!');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente!');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }

  editUserName(newNome, context) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'nome': newNome});
  }

  editUserEmail(newEmail, context) async {}

  editUserSenha(newSenha, context) async {}

  deleteUser(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .delete()
        .catchError((error) => print('Delete failed $error'));
    _authCheck();
  }
}
