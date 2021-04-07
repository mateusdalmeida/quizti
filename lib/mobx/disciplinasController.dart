import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'disciplinasController.g.dart';

final db = FirebaseFirestore.instance;
class DisciplinasController = DisciplinasControllerBase
    with _$DisciplinasController;

abstract class DisciplinasControllerBase with Store {
  // DisciplinasControllerBase() {
  //   db.collection("disciplinas").get().then((value) => {
  //         value.docs.forEach((doc) {
  //           addToList(doc);
  //         }),
  //         InitialScreen.screenDataInt.value++
  //       });
  // }

  @observable
  ObservableMap disciplinasMap = ObservableMap();

  @observable
  ObservableList disciplinasList = ObservableList();

  @action
  setDisciplinasList(List disciplinas) {
    disciplinasList = ObservableList();
    ObservableMap temp = ObservableMap();
    disciplinasMap.forEach((key, value) {
      temp = ObservableMap();
      temp["id"] = key;
      temp['nome'] = value['nome'];
      temp['isMatriculado'] = disciplinas.contains(key);
      disciplinasList.add(temp);
    });
  }

  @action
  changeIsMatriculado(bool value, int index) {
    disciplinasList[index]['isMatriculado'] = value;
  }

  @action
  void addListOfDisciplinas(List<QueryDocumentSnapshot> disciplinas) {
    disciplinas.forEach((item) {
      disciplinasMap[item.id] = item.data();
    });
  }

  @action
  void addToList(DocumentSnapshot item) {
    disciplinasMap[item.id] = item.data();
  }
}
