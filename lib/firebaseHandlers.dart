import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

Future getAssuntos() async {
  return await db.collection("assuntos").get();
}

Future getConquistas() async {
  return await db
      .collection("conquistas")
      .orderBy("order", descending: false)
      .get();
}

Future getDisciplinas() async {
  return await db.collection("disciplinas").get();
}

Future getQuests() async {
  return await db.collection("quests").get();
}

Future getQuizzes() async {
  return await db.collection("quizzes").get();
}

Future getUserById(String userID) async {
  return db.collection("users").doc(userID).get();
}

Future getUsers() async {
  return await db.collection("users").get();
}
