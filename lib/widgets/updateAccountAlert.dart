import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/main.dart';
import 'package:tcc/mobx/disciplinasController.dart';
import 'package:tcc/mobx/screenController.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/ui/dashboard.dart';
import 'package:tcc/widgets/miniButton.dart';

final db = FirebaseFirestore.instance;

void showUpdateAccountAlert(BuildContext context) {
  final disciplinasController =
      Provider.of<DisciplinasController>(context, listen: false);
  final screenController =
      Provider.of<ScreenController>(context, listen: false);

  final userController = Provider.of<UserController>(context, listen: false);

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Bem vindo",
          style: TextStyle(fontSize: 20, color: Colors.deepPurple),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Precisamos atualizar algumas informações"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Escolher Disciplinas",
                    style: TextStyle(fontSize: 20)),
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      disciplinasController.disciplinasList.length, (index) {
                    return Observer(builder: (context) {
                      if (disciplinasController.disciplinasList[index]
                              ['nome'] ==
                          "Testes") return SizedBox();
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                        checkColor: Colors.deepPurple,
                        title: Text(disciplinasController.disciplinasList[index]
                            ['nome']),
                        value: disciplinasController.disciplinasList[index]
                            ['isMatriculado'],
                        onChanged: screenController.isLoading
                            ? null
                            : (bool value) {
                                disciplinasController.changeIsMatriculado(
                                    value, index);
                              },
                      );
                    });
                  })),
              screenController.errorDisciplinas != ""
                  ? Center(
                      child: Text(screenController.errorDisciplinas,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)))
                  : SizedBox(),
              screenController.errorFirebase != ""
                  ? Center(
                      child: Text(screenController.errorFirebase,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)))
                  : SizedBox(),
            ],
          ),
        ),
        actions: <Widget>[
          MiniButton(
            "Salvar",
            onPressed: () async {
              List disciplinas = List();
              disciplinasController.disciplinasList.forEach((el) {
                if (el['isMatriculado']) disciplinas.add(el['id']);
              });
              if (disciplinas.length == 0) {
                screenController.setErrorDisciplinas("Escolha uma disciplina");
              } else {
                screenController.setErrorDisciplinas("");
              }
              await db
                  .collection("users")
                  .doc(InitialScreen.user.uid)
                  .update({'disciplinas': disciplinas, "updated": true});
              userController.updateUser('updated', true);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Dashboard()),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      );
    },
  );
}
