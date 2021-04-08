import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/assuntosController.dart';
import 'package:tcc/mobx/questsController.dart';
import 'package:tcc/mobx/quizController.dart';
import 'package:tcc/mobx/disciplinasController.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/mobx/conquistasController.dart';
import 'package:tcc/mobx/rankingController.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/widgets/participationAlert.dart';
import 'package:tcc/widgets/updateAccountAlert.dart';
import 'package:tcc/ui/login.dart';
import 'package:tcc/ui/quiz.dart';
import 'package:tcc/ui/ranking.dart';
import 'package:tcc/ui/settings.dart' as settings;
import 'package:tcc/ui/stats.dart';
import 'package:tcc/ui/conquistas.dart';
import 'package:tcc/widgets/miniButton.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../main.dart';

final db = FirebaseFirestore.instance;
final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    final userController = Provider.of<UserController>(context);
    final quizController = Provider.of<QuizController>(context);
    final disciplinasController = Provider.of<DisciplinasController>(context);
    final conquistasController = Provider.of<ConquistasController>(context);
    final rankingController = RankingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.usersMap[InitialScreen.user.uid]['participation'] ==
          null) {
        showParticipationAlert(context);
      }
      if (userController.usersMap[InitialScreen.user.uid]['updated'] == null) {
        showUpdateAccountAlert(context);
      }
      quizController.addQuizList(
          userController.usersMap[InitialScreen.user.uid]['disciplinas']);
      disciplinasController.setDisciplinasList(
          userController.usersMap[InitialScreen.user.uid]['disciplinas']);
    });

    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Hero(
            tag: "heroDashboard",
            child: ElevatedButton(
                child: Text("Sair"),
                onPressed: () {
                  _auth.signOut().then((value) => Navigator.of(context)
                      .pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false));
                }),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //quizzes
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicHeight(
                    child: Observer(builder: (_) {
                      cards = [];
                      quizController.quizList.forEach((quiz) {
                        cards.add(
                          quizCard(quiz, context),
                        );
                        if (quizController.quizList.last != quiz) {
                          cards.add(SizedBox(
                            width: 16,
                          ));
                        }
                      });
                      return Row(children: cards);
                    }),
                  ),
                ),
                //RunTestes
                Observer(builder: (_) {
                  if (userController.usersMap[InitialScreen.user.uid]
                          ["runTests"] ==
                      null) {
                    return SizedBox();
                  } else {
                    rankingController.calcTestPoints(
                        userController
                            .usersMap[InitialScreen.user.uid]["runTests"]
                            .last['quest'],
                        "single");
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                            alignment: Alignment.center,
                            fit: BoxFit.none,
                            image: AssetImage("img/stats.png")),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: "statsText",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text("Estatistícas",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800])),
                                  ),
                                ),
                                Text("Ultimo Teste",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800])),
                                Text(
                                    "Acertos: " +
                                        rankingController.lastTest['acertos']
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800])),
                                Text(
                                    "Tempo Total: " +
                                        getHora(
                                            rankingController.lastTest['time']),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                        Hero(
                            tag: "statsBtn",
                            child: btn("Ver Todos", Stats(), context))
                      ],
                    ),
                  );
                }),
                //Ranking
                Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                            alignment: Alignment.centerRight,
                            fit: BoxFit.contain,
                            image: AssetImage("img/ranking.jpg")),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: "rankingText",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text("Ranking",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800])),
                                  ),
                                ),
                                Observer(builder: (_) {
                                  int points = 0;
                                  if (userController
                                              .usersMap[InitialScreen.user.uid]
                                          ["runTests"] !=
                                      null) {
                                    points +=
                                        rankingController.getUserPontuation(
                                            userController.usersMap[
                                                    InitialScreen.user.uid]
                                                ["runTests"]);
                                  }
                                  return Text("Pontuação: " + points.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800]));
                                }),
                                SizedBox(height: 32)
                              ],
                            ),
                          ),
                        ),
                        Hero(
                            tag: "ranking",
                            child: btn("Ver Todos", Ranking(), context))
                      ],
                    )),
                //Conquistas
                Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                            alignment: Alignment.centerRight,
                            fit: BoxFit.contain,
                            image: AssetImage("img/conquistas.png")),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Observer(builder: (_) {
                              String userConquistas = "";
                              if (userController
                                          .usersMap[InitialScreen.user.uid]
                                      ['conquistas'] ==
                                  null)
                                userConquistas = '0';
                              else
                                userConquistas = userController
                                    .usersMap[InitialScreen.user.uid]
                                        ['conquistas']
                                    .length
                                    .toString();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Hero(
                                    tag: "conquistasText",
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Text("Conquistas",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800])),
                                    ),
                                  ),
                                  Text(
                                      "Realizadas: " +
                                          userConquistas +
                                          " de " +
                                          conquistasController
                                              .conquistasMap.length
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800])),
                                  SizedBox(
                                    height: 32,
                                  )
                                ],
                              );
                            }),
                          ),
                        ),
                        Hero(
                            tag: "conquistas",
                            child: btn("Ver Todos", Conquistas(), context)),
                      ],
                    )),
                //settings
                Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        Hero(
                          tag: "settingsText",
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text("Configurações",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800])),
                          ),
                        ),
                        Hero(
                            tag: "settings",
                            child: btn("Abrir", settings.Settings(), context)),
                      ],
                    )),
              ],
            ),
          )),
        ));
  }

  Widget quizCard(Map quiz, BuildContext context) {
    final disciplinasController = Provider.of<DisciplinasController>(context);
    final questsController = Provider.of<QuestsController>(context);
    final assuntosController = Provider.of<AssuntosController>(context);
    return Hero(
      tag: quiz['id'],
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Observer(builder: (_) {
                  return Text(
                      disciplinasController.disciplinasMap[quiz['disciplina']]
                          ['nome'],
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]));
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      quiz["assunto"].length,
                      (index) => Text(assuntosController
                              .assuntosMap[quiz['assunto'].keys.toList()[index]]
                          ['nome'])),
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: btn(
                      "Iniciar Teste",
                      Quiz(
                        quizId: quiz["id"],
                      ),
                      context,
                      minWidth: double.infinity,
                      quiz: quiz,
                      questsController: questsController))
            ],
          ),
        ),
      ),
    );
  }

  Widget btn(title, goTo, context, {quiz, questsController, minWidth}) {
    return MiniButton(
      title,
      minWidth: minWidth,
      onPressed: () {
        if (quiz != null) {
          questsController.setQuestsQuiz(quiz);
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => goTo));
      },
    );
  }
}
