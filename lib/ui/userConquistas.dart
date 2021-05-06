import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizti/mobx/userController.dart';
import 'package:quizti/mobx/conquistasController.dart';

class UserConquistas extends StatelessWidget {
  final String id;

  UserConquistas(this.id);

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final conquistasController = Provider.of<ConquistasController>(context);

    int conquistas;
    if (userController.usersMap[id]['conquistas'] == null)
      conquistas = 0;
    else
      conquistas = userController.usersMap[id]['conquistas'].length;
    return Scaffold(
      appBar: PreferredSize(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Conquistas",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                  Text(userController.usersMap[id]['name'],
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(200)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: conquistas,
            itemBuilder: (context, index) {
              var conquitasItem = conquistasController.conquistasMap[
                  userController.usersMap[id]['conquistas'][index]];
              double percent = (conquitasItem['realizaram'] /
                      userController.usersMap.length) *
                  100;
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
                              conquitasItem['stars'],
                              (index) =>
                                  Icon(Icons.star, color: Colors.yellow[700])))
                    ],
                  ),
                  title: Text(conquitasItem['name'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(conquitasItem['description'],
                          style: TextStyle(fontSize: 20)),
                      Text(percent.toStringAsFixed(2) + " % já possuem",
                          style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Hero(
          tag: userController.usersMap[id]['name'],
          child: ElevatedButton(
            child: Text("Voltar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
