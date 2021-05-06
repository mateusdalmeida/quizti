import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizti/main.dart';
import 'package:quizti/mobx/userController.dart';
import 'package:quizti/widgets/miniButton.dart';

final db = FirebaseFirestore.instance;

void showParticipationAlert(BuildContext context) {
  final userController = Provider.of<UserController>(context, listen: false);

  String userName = userController.usersMap[InitialScreen.user.uid]['name'];

  String term =
      "Eu, $userName permito que meus dados de uso deste aplicativo sejam utilizados na pesquisa acadêmica de Mateus Corrêa D’Almeida, bem como aceito que minha participação possa ser usada como componente avaliativa da disciplina Algebra Linear e Geometria Analitica no semestre 2020.3.";
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Termos de uso",
          style: TextStyle(color: Colors.deepPurple),
        ),
        content: SingleChildScrollView(child: Text(term)),
        actions: <Widget>[
          MiniButton(
            "Negar",
            onPressed: () async {
              await db
                  .collection("users")
                  .doc(InitialScreen.user.uid)
                  .update({'participation': false});
              Navigator.pop(context);
            },
          ),
          MiniButton(
            "Aceitar",
            onPressed: () async {
              await db
                  .collection("users")
                  .doc(InitialScreen.user.uid)
                  .update({'participation': true});
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
