import 'package:akangatu_project/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowGreenDialog extends StatelessWidget {
  const ShowGreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      scrollable: true,
      title: Image.asset(
        'images/icon/COLORFUL/ColorfulLogo.png',
        height: 65,
      ),
      content: const Text(
        'Parabéns pelo domínio do conteúdo.\nContinue brilhando! 🎉',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      contentPadding: EdgeInsets.only(top: 15, left: 25, right: 25),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'Fechar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(bottom: 10, right: 20),
    );
  }
}

class ShowRedDialog extends StatelessWidget {
  const ShowRedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      scrollable: true,
      title: Image.asset(
        'images/icon/COLORFUL/ColorfulLogo.png',
        height: 65,
      ),
      content: const Text(
        'Ainda não está familiarizado com o conteúdo? Saiba que a jornada é gradual. \nNão desista de tentar! 💕',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      contentPadding: EdgeInsets.only(top: 15, left: 25, right: 25),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'Fechar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(bottom: 10, right: 20),
    );
  }
}

class ShowLateDialog extends StatelessWidget {
  const ShowLateDialog({super.key});

  showNotification(BuildContext context) {
    print('///////////////////////////////////////////');
    Provider.of<NotificationService>(context, listen: false)
        .showLocalNotification(CustomNotification(
            id: 1,
            title: 'Ei, você tem cards para revisar!',
            body:
                'Lembra dos cards que você adiou? É hora de dar uma olhadinha neles!',
            context: context));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      scrollable: true,
      title: Image.asset(
        'images/icon/COLORFUL/ColorfulLogo.png',
        height: 65,
      ),
      content: const Text(
        'Não consegue lembrar do conteúdo? Volte amanhã e tente novamente. \nNão desista de tentar! 🧠',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      contentPadding: EdgeInsets.only(top: 15, left: 25, right: 25),
      actions: [
        TextButton(
          onPressed: () => showNotification(context),
          child: Text(
            'Adiar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'Fechar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(bottom: 10, right: 20),
    );
  }
}
