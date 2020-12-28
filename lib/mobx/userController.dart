import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

part 'userController.g.dart';

class UserController = UserControllerBase with _$UserController;
final db = FirebaseFirestore.instance;

abstract class UserControllerBase with Store {
  UserControllerBase() {
    db.collection("users").snapshots().forEach((docs) {
      docs.docChanges.reversed.forEach((changes) {
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
  ObservableMap usersMap = ObservableMap();

  @action
  updateUser(String field, value) {
    usersMap[InitialScreen.user.uid][field] = value;
  }

  @action
  void addToList(DocumentSnapshot item) {
    usersMap[item.id] = item.data();
  }
}
