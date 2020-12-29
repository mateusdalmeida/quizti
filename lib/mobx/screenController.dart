import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
part 'screenController.g.dart';

final db = FirebaseFirestore.instance;

class ScreenController = _ScreenControllerBase with _$ScreenController;

abstract class _ScreenControllerBase with Store {
  //observables da tela de questoes
  @observable
  int selectedQuest = 0;

  @observable
  int quizListIndex = 0;

  @observable
  String errorDisciplinas = "";

  @observable
  bool isLoading = false;

  @observable
  String errorFirebase = "";

  @action
  setIsLoading(bool value) {
    isLoading = value;
  }

  @action
  setErrorFirebase(String error) {
    errorFirebase = error;
  }

  @action
  setErrorDisciplinas(String msg) {
    errorDisciplinas = msg;
  }
}
