import 'package:flutter/material.dart';
import 'package:tcc/mobx/conquistasController.dart';
import 'package:tcc/ui/dashboard.dart';
import 'package:tcc/ui/runTest.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/mobx/rankingController.dart';
import 'package:tcc/widgets/miniButton.dart';
import 'package:tcc/utils.dart';

import '../main.dart';

class Results extends StatefulWidget {
  final List conquistas;

  const Results({Key key, this.conquistas}) : super(key: key);
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.conquistas.length != 0) {
        for (String conquista in widget.conquistas) {
          showAlert(context, conquista);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    final rankingController = RankingController();
    String id = InitialScreen.user.uid;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              child: Text("Resultado detalhado"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RunTest(
                            userController.usersMap[id]["runTests"].last)));
              },
            ),
            SizedBox(height: 16),
            Hero(
              tag: "heroDashboard",
              child: ElevatedButton(
                child: Text("Voltar pro Inicio"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Observer(builder: (context) {
              rankingController.calcTestPoints(
                  userController.usersMap[id]["runTests"].last['quest'],
                  "single");

              Map lastTest = rankingController.lastTest;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Quiz Concluído",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                  Text("Tempo Total: " + getHora(lastTest['time']),
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  Text("Resolvidas: " + lastTest['solved'].toString(),
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  Text("Acertos: " + lastTest['acertos'].toString(),
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  Text(
                      "Você ganhou " +
                          rankingController.testPoints.toString() +
                          " pontos",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context, String conquista) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final conquistasController = Provider.of<ConquistasController>(context);
        return AlertDialog(
          title: Text(
            conquistasController.conquistasMap[conquista]['name'],
            style: TextStyle(color: Colors.deepPurple),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  conquistasController.conquistasMap[conquista]['description']),
              // Text("% usuarios possuem"),
            ],
          ),
          actions: <Widget>[
            MiniButton(
              "Fechar",
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
