import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'quizController.g.dart';

class QuizController = QuizControllerBase with _$QuizController;
final db = FirebaseFirestore.instance;

abstract class QuizControllerBase with Store {
  // QuizControllerBase() {
  //   db.collection("quizzes").snapshots().forEach((docs) {
  //     docs.docChanges.reversed.forEach((changes) {
  //       switch (changes.type) {
  //         case DocumentChangeType.removed:
  //           break;
  //         default:
  //           addToQuizzesMap(changes.doc);
  //           break;
  //       }
  //     });
  //     InitialScreen.screenDataInt.value++;
  //   });
  // }

  @observable
  ObservableMap quizzesMap = ObservableMap();

  @observable
  ObservableList quizList = ObservableList();

  @action
  void addListOfQuizzes(List<QueryDocumentSnapshot> quizzes) {
    quizzes.forEach((item) {
      Map aux = item.data();
      aux['id'] = item.id;
      quizzesMap[item.id] = aux;
    });
  }

  @action
  addToQuizzesMap(DocumentSnapshot item) {
    Map aux = item.data();
    aux['id'] = item.id;
    quizzesMap[item.id] = aux;
  }

  @action
  addQuizList(List disciplinas) {
    quizList.clear();
    quizzesMap.forEach((key, value) {
      if (disciplinas.contains(value['disciplina'])) quizList.add(value);
    });
  }
}
