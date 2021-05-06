import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quizti/mobx/conquistasController.dart';

import 'package:quizti/mobx/userController.dart';
import 'package:quizti/ui/dashboard.dart';
import 'package:quizti/main.dart';
import 'package:provider/provider.dart';

class Conquistas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final conquistasController = Provider.of<ConquistasController>(context);
    final userController = Provider.of<UserController>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "conquistasText",
                child: Material(
                  type: MaterialType.transparency,
                  child: Text("Conquistas",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                ),
              ),
              Observer(
                builder: (context) {
                  List conquistas =
                      conquistasController.conquistasMap.values.toList();
                  List conquistasKeys =
                      conquistasController.conquistasMap.keys.toList();
                  // print(rankingController.testPoints);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: conquistas.length,
                      itemBuilder: (context, index) {
                        bool concluiu;
                        if (userController.usersMap[InitialScreen.user.uid]
                                ['conquistas'] ==
                            null) {
                          concluiu = false;
                        } else if (userController
                            .usersMap[InitialScreen.user.uid]['conquistas']
                            .contains(conquistasKeys[index])) {
                          concluiu = true;
                        } else {
                          concluiu = false;
                        }
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                        conquistas[index]['stars'],
                                        (index) => Icon(Icons.star,
                                            color: concluiu
                                                ? Colors.yellow[700]
                                                : Colors.grey)))
                              ],
                            ),
                            title: Text(conquistas[index]['name'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            subtitle: Visibility(
                              visible: conquistas[index]['realizaram'] == 1,
                              child: Text(
                                  conquistas[index]['description'] +
                                      "\n" +
                                      conquistas[index]['realizaram']
                                          .toString() +
                                      " usuário",
                                  style: TextStyle(fontSize: 20)),
                              replacement: Text(
                                  conquistas[index]['description'] +
                                      "\n" +
                                      (conquistas[index]['realizaram'] == null
                                              ? "0"
                                              : conquistas[index]['realizaram'])
                                          .toString() +
                                      " usuários",
                                  style: TextStyle(fontSize: 20)),
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 8),
              Hero(
                tag: "conquistas",
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
      ),
    );
  }
}
