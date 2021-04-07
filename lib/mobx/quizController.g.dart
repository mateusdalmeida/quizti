// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quizController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuizController on QuizControllerBase, Store {
  final _$quizzesMapAtom = Atom(name: 'QuizControllerBase.quizzesMap');

  @override
  ObservableMap<dynamic, dynamic> get quizzesMap {
    _$quizzesMapAtom.reportRead();
    return super.quizzesMap;
  }

  @override
  set quizzesMap(ObservableMap<dynamic, dynamic> value) {
    _$quizzesMapAtom.reportWrite(value, super.quizzesMap, () {
      super.quizzesMap = value;
    });
  }

  final _$quizListAtom = Atom(name: 'QuizControllerBase.quizList');

  @override
  ObservableList<dynamic> get quizList {
    _$quizListAtom.reportRead();
    return super.quizList;
  }

  @override
  set quizList(ObservableList<dynamic> value) {
    _$quizListAtom.reportWrite(value, super.quizList, () {
      super.quizList = value;
    });
  }

  final _$QuizControllerBaseActionController =
      ActionController(name: 'QuizControllerBase');

  @override
  void addListOfQuizzes(List<QueryDocumentSnapshot> quizzes) {
    final _$actionInfo = _$QuizControllerBaseActionController.startAction(
        name: 'QuizControllerBase.addListOfQuizzes');
    try {
      return super.addListOfQuizzes(quizzes);
    } finally {
      _$QuizControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addToQuizzesMap(DocumentSnapshot item) {
    final _$actionInfo = _$QuizControllerBaseActionController.startAction(
        name: 'QuizControllerBase.addToQuizzesMap');
    try {
      return super.addToQuizzesMap(item);
    } finally {
      _$QuizControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addQuizList(List<dynamic> disciplinas) {
    final _$actionInfo = _$QuizControllerBaseActionController.startAction(
        name: 'QuizControllerBase.addQuizList');
    try {
      return super.addQuizList(disciplinas);
    } finally {
      _$QuizControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quizzesMap: ${quizzesMap},
quizList: ${quizList}
    ''';
  }
}
