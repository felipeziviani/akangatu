import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../screens/login_register_screen.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

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
            users.doc(usuario!.uid).set({
              'nome': nome,
              'email': email,
              'senha': senhaMd5,
            });
            //users.add({
            //  'uid': usuario!.uid,
            //  'nome': nome,
            //  'email': email,
            //  'senha': senhaMd5,
            //});
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

  editarNome(newName, context) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(newName).then(
          (value) => FirebaseFirestore.instance
              .collection('users')
              .doc(usuario!.uid)
              .update({'nome': newName}));
      _getUser();
    } on FirebaseAuthException catch (e) {
      print('$e');
    }
  }

  editEmail(newEmail, context) async {
    print("####################### $newEmail");
    try {
      await FirebaseAuth.instance.currentUser!.updateEmail(newEmail).then(
          (value) => FirebaseFirestore.instance
              .collection('users')
              .doc(usuario!.uid)
              .update({'email': newEmail}));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw AuthException('O e-mail é invalido!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está sendo usado!');
      }
    }
  }

  editSenha(currentEmail, oldSenha, newSenha, context) async {
    String oldSenhaMd5 = md5.convert(utf8.encode(oldSenha)).toString();
    String newSenhaMd5 = md5.convert(utf8.encode(newSenha)).toString();

    var cred = EmailAuthProvider.credential(
        email: currentEmail, password: oldSenhaMd5);

    try {
      await usuario!
          .reauthenticateWithCredential(cred)
          .then((value) => {usuario!.updatePassword(newSenhaMd5)})
          .catchError((error) {
        print(error.toString());
      }).then((value) => FirebaseFirestore.instance
              .collection('users')
              .doc(usuario!.uid)
              .update({'senha': newSenhaMd5}));
    } on FirebaseAuthException catch (e) {
      print('$e');
    }
  }

  deleteUser(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(usuario!.uid)
          .delete()
          .then((value) => FirebaseAuth.instance.currentUser!.delete());
      logout();
    } on FirebaseAuthException catch (e) {
      print('$e');
    }
  }
}
