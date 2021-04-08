import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/ui/dashboard.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/disciplinasController.dart';
import 'package:tcc/mobx/screenController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/widgets/loadingButton.dart';

final db = FirebaseFirestore.instance;

class Settings extends StatelessWidget {
  final screenController = ScreenController();
  @override
  Widget build(BuildContext context) {
    final disciplinasController = Provider.of<DisciplinasController>(context);
    final userController = Provider.of<UserController>(context);

    return Scaffold(
      appBar: PreferredSize(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Hero(
                tag: "settingsText",
                child: Material(
                  type: MaterialType.transparency,
                  child: Text("Configurações",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(100)),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Hero(
          tag: "heroDashboard",
          child: Observer(builder: (context) {
            return ElevatedButton(
              child: Text("Voltar pro Inicio"),
              onPressed: screenController.isLoading
                  ? null
                  : () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    },
            );
          }),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: <Widget>[
            ExpansionTile(
                title: Text(
                  "Escolher Disciplinas",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                children: List.generate(
                    disciplinasController.disciplinasList.length, (index) {
                  return Observer(builder: (context) {
                    if (!(userController.usersMap[InitialScreen.user.uid]
                                ['tipo'] ==
                            'adm') &&
                        disciplinasController.disciplinasList[index]['nome'] ==
                            "Testes") return SizedBox();
                    return CheckboxListTile(
                      checkColor: Colors.deepPurple,
                      title: Text(
                          disciplinasController.disciplinasList[index]['nome'],
                          style: TextStyle(color: Colors.white)),
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
            Center(
              child: Observer(builder: (_) {
                return Text(screenController.errorDisciplinas,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold));
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Hero(
                tag: "settings",
                child: Observer(builder: (context) {
                  return LoadingButton(
                    label: "Salvar Alterações",
                    onPressed: screenController.isLoading
                        ? null
                        : () async {
                            List disciplinas = [];
                            disciplinasController.disciplinasList.forEach((el) {
                              if (el['isMatriculado'])
                                disciplinas.add(el['id']);
                            });
                            if (disciplinas.length == 0) {
                              screenController.setErrorDisciplinas(
                                  "Escolha uma disciplina");
                            } else {
                              screenController.setErrorDisciplinas("");
                              screenController.setIsLoading(true);
                              await db
                                  .collection("users")
                                  .doc(InitialScreen.user.uid)
                                  .update({'disciplinas': disciplinas});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()));
                            }
                          },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
