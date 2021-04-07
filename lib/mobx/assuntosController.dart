import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'assuntosController.g.dart';

class AssuntosController = AssuntosControllerBase with _$AssuntosController;
final db = FirebaseFirestore.instance;

abstract class AssuntosControllerBase with Store {
  // AssuntosControllerBase() {
  //   db.collection("assuntos").snapshots().forEach((docs) {
  //     docs.docChanges.reversed.forEach((changes) {
  //       switch (changes.type) {
  //         case DocumentChangeType.removed:
  //           break;
  //         default:
  //           addToAssuntosMap(changes.doc);
  //           break;
  //       }
  //     });
  //     InitialScreen.screenDataInt.value++;
  //   });
  // }

  @observable
  ObservableMap assuntosMap = ObservableMap();

  @action
  void addListOfAsssuntos(List<QueryDocumentSnapshot> assuntos) {
    assuntos.forEach((item) {
      assuntosMap[item.id] = item.data();
    });
  }

  @action
  addToAssuntosMap(DocumentSnapshot item) {
    assuntosMap[item.id] = item.data();
  }
}
