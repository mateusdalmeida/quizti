import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/rankingController.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/ui/dashboard.dart';
import 'package:tcc/ui/runTest.dart';
import 'package:tcc/widgets/miniButton.dart';
import 'package:tcc/utils.dart';

import '../main.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final rankingController = RankingController();
    String id = InitialScreen.user.uid;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "statsText",
                child: Material(
                  type: MaterialType.transparency,
                  child: Text("Estatistícas",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                ),
              ),
              Expanded(
                child: Observer(builder: (context) {
                  var runTests =
                      userController.usersMap[id]["runTests"].reversed.toList();

                  return ListView.builder(
                    // reverse: true,
                    // shrinkWrap: true,
                    itemCount: runTests.length,
                    itemBuilder: (context, index) {
                      var date = runTests[index]['date'];
                      rankingController.calcTestPoints(
                          runTests[index]['quest'], "single");
                      return Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Quiz " + (index + 1).toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800])),
                                  date != null
                                      ? Text(getData(date),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey[800]))
                                      : SizedBox(),
                                  Text(
                                      "Acertos: " +
                                          rankingController.lastTest['acertos']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[800])),
                                  Text(
                                      "Tempo: " +
                                          getHora(rankingController
                                              .lastTest['time']),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[800])),
                                ],
                              )),
                              MiniButton(
                                "Detalhes",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RunTest(runTests[index])));
                                },
                              ),
                            ],
                          ));
                    },
                  );
                }),
              ),
              SizedBox(height: 8),
              Hero(
                tag: "statsBtn",
                child: ElevatedButton(
                  child: Text("Voltar pro Inicio"),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
