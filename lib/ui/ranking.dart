import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/firebaseHandlers.dart';
import 'package:tcc/mobx/rankingController.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/ui/dashboard.dart';
import 'package:tcc/ui/userConquistas.dart';
import 'package:tcc/widgets/miniButton.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rankingController = RankingController();
    final userController = Provider.of<UserController>(context);

    Future teste;
    if (userController.usersMap.length > 1) {
      teste = Future.delayed(Duration(seconds: 0)).then((value) => "");
    } else {
      teste = getUsers();
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "rankingText",
                child: Material(
                  type: MaterialType.transparency,
                  child: Text("Ranking",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                ),
              ),
              FutureBuilder(
                  future: teste,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      if (snapshot.data.runtimeType != String) {
                        userController.addListOfUsers(snapshot.data.docs);
                      }
                      rankingController.getRanking(context);

                      return Observer(
                        builder: (context) {
                          List ranking = rankingController.ranking;
                          // print(rankingController.testPoints);
                          return Flexible(
                            child: ListView.builder(
                              // shrinkWrap: true,
                              itemCount: ranking.length,
                              itemBuilder: (context, index) {
                                Color backColor = Colors.white;
                                switch (index) {
                                  case 0:
                                    backColor = Colors.yellow;
                                    break;
                                  case 1:
                                    backColor = Colors.grey[300];
                                    break;
                                  case 2:
                                    backColor =
                                        Color.fromARGB(255, 205, 127, 50);
                                    break;
                                }
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                      color: backColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ListTile(
                                    leading: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Hero(
                                      tag: ranking[index]['name'],
                                      child: MiniButton(
                                        "Conquistas",
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserConquistas(
                                                          ranking[index]
                                                              ['id'])));
                                        },
                                      ),
                                    ),
                                    title: Text(ranking[index]['name'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                        ranking[index]['points'].toString() +
                                            " pontos",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  }),
              SizedBox(height: 8),
              Hero(
                tag: "ranking",
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
