import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'questsController.g.dart';

class QuestsController = QuestsControllerBase with _$QuestsController;
final db = FirebaseFirestore.instance;

abstract class QuestsControllerBase with Store {
  // QuestsControllerBase() {
  //   db.collection("quests").snapshots().forEach((docs) {
  //     docs.docChanges.forEach((changes) {
  //       switch (changes.type) {
  //         case DocumentChangeType.removed:
  //           break;
  //         default:
  //           addQuestsList(changes.doc);
  //           break;
  //       }
  //     });
  //     InitialScreen.screenDataInt.value++;
  //   });
  // }
  @observable
  ObservableList questsList = ObservableList();

  @observable
  ObservableList questsQuizList = ObservableList();

  @action
  void addListOfQuests(List<QueryDocumentSnapshot> quests) {
    quests.forEach((item) {
      Map tempQuest = item.data();
      tempQuest['id'] = item.id;
      questsList.add(tempQuest);
    });
  }

  @action
  addQuestsList(DocumentSnapshot item) {
    Map tempQuest = item.data();
    tempQuest['id'] = item.id;
    questsList.add(tempQuest);
  }

  // @action
  // addToQuestsList(Map quizzes) {
  //   questsList.add(quizzes);
  // }

  @action
  setQuestsQuiz(quiz) {
    questsQuizList = ObservableList();
    quiz['assunto'].forEach((k, v) {
      var temp = [];
      temp = questsList.where((quest) => quest['assunto'] == k).toList();
      temp.shuffle();
      questsQuizList.addAll(temp.sublist(0, v));
    });
    questsQuizList.shuffle();
  }

  // @action
  // getQuests(List disciplinas) async {
  //   questsList = ObservableList();
  //   var result = await db
  //       .collection("quests")
  //       .where("disciplina", whereIn: disciplinas)
  //       .getDocuments();
  //   result.documents.map((e) {
  //     var aux = e.data;
  //     aux['id'] = e.id;
  //     addToQuestsList(aux);
  //   }).toList();
  //   return 1;
  // }
}
