import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/questsController.dart';
import 'package:tcc/mobx/screenController.dart';
import 'package:tcc/mobx/conquistasController.dart';
import 'package:tcc/mobx/userController.dart';

import 'package:tcc/ui/results.dart';
import 'package:tcc/mobx/assuntosController.dart';
import 'package:tcc/widgets/detailsItem.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

final db = FirebaseFirestore.instance;

class Quiz extends StatefulWidget {
  final String quizId;

  const Quiz({Key key, this.quizId}) : super(key: key);
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  void initState() {
    super.initState();
    timer.start();
  }

  Map<String, dynamic> questsData = new Map();

  Stopwatch timer = new Stopwatch();
  int totalTime = 0;

  BoxDecoration noSelected = BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(30));
  BoxDecoration selected = BoxDecoration(
      border: Border.all(color: Colors.deepPurple, width: 4),
      borderRadius: BorderRadius.circular(30));

  @override
  Widget build(BuildContext context) {
    final questsController = Provider.of<QuestsController>(context);
    final screenController = Provider.of<ScreenController>(context);
    final assuntosController = Provider.of<AssuntosController>(context);

    screenController.quizListIndex = 0;
    screenController.selectedQuest = 0;
    return Scaffold(
        body: SafeArea(
      child: Hero(
        tag: widget.quizId,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Observer(builder: (_) {
                var quests = questsController.questsQuizList;
                return Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      //Exibir o assunto da questão
                      Expanded(
                          child: Text(
                              assuntosController.assuntosMap[
                                      quests[screenController.quizListIndex]
                                          ['assunto']]['nome']
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800]))),
                      //contador de questão
                      Text(
                          (screenController.quizListIndex + 1).toString() + '/',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800])),
                      Text(quests.length.toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]))
                    ],
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                        //cabeçalho
                        //pergunta
                        DetailsItem(
                            quests[screenController.quizListIndex]['pergunta'],
                            bigFont: true),
                        Divider(color: Colors.grey),
                        Divider(),
                        //alternativas
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: quests[screenController.quizListIndex]
                                  ['alternativas']
                              .length,
                          itemBuilder: (ctx, count) {
                            var position = (count + 1).toString();
                            return quest(
                              count + 1,
                              screenController,
                              quests[screenController.quizListIndex]
                                  ['alternativas'][position],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                        )
                      ]))),
                  Divider(),
                  //botao de responder
                  MaterialButton(
                      elevation: 0,
                      minWidth: double.infinity,
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Text("Responder"),
                      onPressed: screenController.selectedQuest == 0
                          ? null
                          : () {
                              if (screenController.quizListIndex <=
                                  quests.length) {
                                //modal de resultado
                                _showModalSheet();
                              }
                            })
                ]);
              })),
        ),
      ),
    ));
  }

  Widget quest(order, ScreenController screenController, alternativa) {
    return GestureDetector(
        onTap: () {
          screenController.selectedQuest = order;
        },
        child: Container(
            width: double.infinity,
            decoration: screenController.selectedQuest == order
                ? this.selected
                : this.noSelected,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DetailsItem(alternativa),
            )));
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          final questsController = Provider.of<QuestsController>(context);
          final screenController = Provider.of<ScreenController>(context);
          final conquistasController =
              Provider.of<ConquistasController>(context);
          final userController = Provider.of<UserController>(context);
          bool isCorrect;
          String result;
          if (questsController.questsQuizList[screenController.quizListIndex]
                      ['correta']
                  .toString() ==
              screenController.selectedQuest.toString()) {
            isCorrect = true;
            result = 'Parabens a resposta está correta';
          } else {
            isCorrect = false;
            result = 'Resposta errada';
          }
          return WillPopScope(
            onWillPop: () async => false,
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              child: StreamBuilder(builder: (context, snapshot) {
                return ListView(
                  padding: EdgeInsets.all(16),
                  children: <Widget>[
                    Text(result,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800])),
                    SizedBox(height: 16),
                    //botao para avançar
                    RaisedButton(
                      elevation: 0,
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Text("Avançar"),
                      onPressed: () async {
                        var index = screenController.quizListIndex;
                        var quests = questsController.questsQuizList;
                        if (index <= quests.length) {
                          Navigator.of(context).pop();
                          timer.stop();

                          totalTime += timer.elapsed.inSeconds;

                          questsData[quests[index]["id"]] = {
                            "time": timer.elapsed.inSeconds,
                            "result": isCorrect,
                            "escolha": screenController.selectedQuest
                          };

                          timer.reset();
                          timer.start();
                          screenController.quizListIndex++;
                          if (screenController.quizListIndex ==
                              questsController.questsQuizList.length) {
                            screenController.quizListIndex = 0;

                            //atualizar o quiz
                            db.collection("quizzes").doc(widget.quizId).update({
                              "time": FieldValue.increment(totalTime),
                              "qtdResolucoes": FieldValue.increment(1),
                            });

                            //atualizar o user

                            var dataToUser = {
                              'quest': questsData,
                              'quiz': widget.quizId,
                              'date': new DateTime.now().millisecondsSinceEpoch
                            };

                            var conquistas = conquistasController.runConquistas(
                                userController.usersMap[InitialScreen.user.uid],
                                InitialScreen.user.uid,
                                lastTest: dataToUser);

                            db
                                .collection("users")
                                .doc(InitialScreen.user.uid)
                                .update({
                              "runTests": FieldValue.arrayUnion([dataToUser]),
                            });

                            //atualizar as quests

                            questsData.forEach((f, a) {
                              print(f);
                              db.collection("quests").doc(f).update({
                                "qtdResolucoes": FieldValue.increment(1),
                                "time": FieldValue.increment(a["time"]),
                                "acertos":
                                    FieldValue.increment(a["result"] ? 1 : 0)
                              });
                            });

                            screenController.selectedQuest = 0;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Results(conquistas: conquistas)));
                          }
                          //colocar aqui
                          screenController.selectedQuest = 0;
                        }
                      },
                    )
                  ],
                );
              }),
            ),
          );
        });
  }
}
