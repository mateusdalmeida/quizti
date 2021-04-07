// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questsController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuestsController on QuestsControllerBase, Store {
  final _$questsListAtom = Atom(name: 'QuestsControllerBase.questsList');

  @override
  ObservableList<dynamic> get questsList {
    _$questsListAtom.reportRead();
    return super.questsList;
  }

  @override
  set questsList(ObservableList<dynamic> value) {
    _$questsListAtom.reportWrite(value, super.questsList, () {
      super.questsList = value;
    });
  }

  final _$questsQuizListAtom =
      Atom(name: 'QuestsControllerBase.questsQuizList');

  @override
  ObservableList<dynamic> get questsQuizList {
    _$questsQuizListAtom.reportRead();
    return super.questsQuizList;
  }

  @override
  set questsQuizList(ObservableList<dynamic> value) {
    _$questsQuizListAtom.reportWrite(value, super.questsQuizList, () {
      super.questsQuizList = value;
    });
  }

  final _$QuestsControllerBaseActionController =
      ActionController(name: 'QuestsControllerBase');

  @override
  void addListOfQuests(List<QueryDocumentSnapshot> quests) {
    final _$actionInfo = _$QuestsControllerBaseActionController.startAction(
        name: 'QuestsControllerBase.addListOfQuests');
    try {
      return super.addListOfQuests(quests);
    } finally {
      _$QuestsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addQuestsList(DocumentSnapshot item) {
    final _$actionInfo = _$QuestsControllerBaseActionController.startAction(
        name: 'QuestsControllerBase.addQuestsList');
    try {
      return super.addQuestsList(item);
    } finally {
      _$QuestsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQuestsQuiz(dynamic quiz) {
    final _$actionInfo = _$QuestsControllerBaseActionController.startAction(
        name: 'QuestsControllerBase.setQuestsQuiz');
    try {
      return super.setQuestsQuiz(quiz);
    } finally {
      _$QuestsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
questsList: ${questsList},
questsQuizList: ${questsQuizList}
    ''';
  }
}
