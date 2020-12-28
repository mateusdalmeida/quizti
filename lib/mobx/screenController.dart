import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
part 'screenController.g.dart';

final db = FirebaseFirestore.instance;

class ScreenController = _ScreenControllerBase with _$ScreenController;

abstract class _ScreenControllerBase with Store {
  @observable
  bool createDashBoard = false;

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
  isLoadingChange(bool value) {
    isLoading = value;
  }

  @action
  changeErrorFirebase(String error) {
    errorFirebase = error;
  }

  @action
  setErrorDisciplinas(String msg) {
    errorDisciplinas = msg;
  }

  @action
  setCreateDashBoardAsFalse() {
    createDashBoard = false;
  }

  @action
  String getHora(segundos) {
    DateTime date = new DateTime.utc(1, 1, 1, 0, 0, 0);
    date = date.add(Duration(seconds: segundos));
    return date.toString().substring(11, 19);
  }

  @action
  String getData(epoch) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(epoch);
    String dateStr = date.toString().substring(0, 16).replaceAll("-", "/");
    String dateAux = dateStr.substring(8, 10);
    dateAux += dateStr.substring(4, 8);
    dateAux += dateStr.substring(0, 4);
    dateAux += dateStr.substring(10);
    return dateAux;
  }
}
