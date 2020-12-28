import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

import '../main.dart';

part 'disciplinasController.g.dart';

final db = FirebaseFirestore.instance;
class DisciplinasController = DisciplinasControllerBase
    with _$DisciplinasController;

abstract class DisciplinasControllerBase with Store {
  DisciplinasControllerBase() {
    db.collection("disciplinas").snapshots().forEach((docs) {
      docs.docChanges.forEach((changes) {
        switch (changes.type) {
          case DocumentChangeType.removed:
            break;
          default:
            addToList(changes.doc);
            break;
        }
      });
      InitialScreen.screenDataInt.value++;
    });
  }

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
  void addToList(DocumentSnapshot item) {
    disciplinasMap[item.id] = item.data();
  }
}
