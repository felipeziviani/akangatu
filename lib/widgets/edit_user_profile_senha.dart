import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_profile_screen.dart';
import '../services/auth_service.dart';

class EditUserPasswordDialog extends StatefulWidget {
  const EditUserPasswordDialog(
      {super.key, required this.field, required this.data, required this.icon});
  final String field;
  final String data;
  final IconData icon;

  @override
  State<EditUserPasswordDialog> createState() => _EditUserPasswordDialogState();
}

class _EditUserPasswordDialogState extends State<EditUserPasswordDialog> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final editFormKey = GlobalKey<FormState>();
  final oldSenha = TextEditingController();
  final newSenha = TextEditingController();

  editUserData(oldSenha, dataToUpdate) async {
    try {
      await context
          .read<AuthService>()
          .editSenha(currentUser.email, oldSenha, dataToUpdate, context);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(e.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        backgroundColor: Colors.deepPurple,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return AlertDialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      scrollable: true,
      title: Container(
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6A1B9A),
              Color(0xFF310C60),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "EDITAR ${widget.field}".toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: editFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: oldSenha,
                style: TextStyle(
                  color: Colors.black,
                ),
                obscureText: true,
                decoration: new InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_open_rounded,
                    color: Color(0xFF4A148C),
                    size: 24,
                  ),
                  hintText: '${widget.data}',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontWeight: FontWeight.bold),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4A148C),
                      width: 2,
                    ),
                  ),
                ),
                // ignore: body_might_complete_normally_nullable
                validator: (value) {
                  if (widget.field == 'Senha' && value!.isEmpty) {
                    return 'Informe a senha!';
                  }
                },
              ),
              Divider(color: Colors.transparent),
              TextFormField(
                controller: newSenha,
                style: TextStyle(
                  color: Colors.black,
                ),
                obscureText: true,
                decoration: new InputDecoration(
                  prefixIcon: Icon(
                    widget.icon,
                    color: Color(0xFF4A148C),
                    size: 24,
                  ),
                  hintText: '${widget.data}',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontWeight: FontWeight.bold),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4A148C),
                      width: 2,
                    ),
                  ),
                ),
                // ignore: body_might_complete_normally_nullable
                validator: (value) {
                  if (widget.field == 'Senha' && value!.isEmpty) {
                    return 'Informe a senha!';
                  } else if (widget.field == 'Senha' && value!.length < 6) {
                    return 'A senha deve ter no mínimo seis caracteres.';
                  }
                },
              ),
              Divider(color: Colors.transparent),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  new EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF6A1B9A),
                    Color(0xFF310C60),
                  ],
                ),
              ),
              width: 125 * fem,
              height: 40 * fem,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                onPressed: () {
                  editUserData(oldSenha.text, newSenha.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
                child: Text(
                  'EDITAR DECK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
