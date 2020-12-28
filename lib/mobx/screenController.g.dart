// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screenController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScreenController on _ScreenControllerBase, Store {
  final _$createDashBoardAtom =
      Atom(name: '_ScreenControllerBase.createDashBoard');

  @override
  bool get createDashBoard {
    _$createDashBoardAtom.reportRead();
    return super.createDashBoard;
  }

  @override
  set createDashBoard(bool value) {
    _$createDashBoardAtom.reportWrite(value, super.createDashBoard, () {
      super.createDashBoard = value;
    });
  }

  final _$selectedQuestAtom = Atom(name: '_ScreenControllerBase.selectedQuest');

  @override
  int get selectedQuest {
    _$selectedQuestAtom.reportRead();
    return super.selectedQuest;
  }

  @override
  set selectedQuest(int value) {
    _$selectedQuestAtom.reportWrite(value, super.selectedQuest, () {
      super.selectedQuest = value;
    });
  }

  final _$quizListIndexAtom = Atom(name: '_ScreenControllerBase.quizListIndex');

  @override
  int get quizListIndex {
    _$quizListIndexAtom.reportRead();
    return super.quizListIndex;
  }

  @override
  set quizListIndex(int value) {
    _$quizListIndexAtom.reportWrite(value, super.quizListIndex, () {
      super.quizListIndex = value;
    });
  }

  final _$errorDisciplinasAtom =
      Atom(name: '_ScreenControllerBase.errorDisciplinas');

  @override
  String get errorDisciplinas {
    _$errorDisciplinasAtom.reportRead();
    return super.errorDisciplinas;
  }

  @override
  set errorDisciplinas(String value) {
    _$errorDisciplinasAtom.reportWrite(value, super.errorDisciplinas, () {
      super.errorDisciplinas = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ScreenControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$errorFirebaseAtom = Atom(name: '_ScreenControllerBase.errorFirebase');

  @override
  String get errorFirebase {
    _$errorFirebaseAtom.reportRead();
    return super.errorFirebase;
  }

  @override
  set errorFirebase(String value) {
    _$errorFirebaseAtom.reportWrite(value, super.errorFirebase, () {
      super.errorFirebase = value;
    });
  }

  final _$_ScreenControllerBaseActionController =
      ActionController(name: '_ScreenControllerBase');

  @override
  dynamic isLoadingChange(bool value) {
    final _$actionInfo = _$_ScreenControllerBaseActionController.startAction(
        name: '_ScreenControllerBase.isLoadingChange');
    try {
      return super.isLoadingChange(value);
    } finally {
      _$_ScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeErrorFirebase(String error) {
    final _$actionInfo = _$_ScreenControllerBaseActionController.startAction(
        name: '_ScreenControllerBase.changeErrorFirebase');
    try {
      return super.changeErrorFirebase(error);
    } finally {
      _$_ScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErrorDisciplinas(String msg) {
    final _$actionInfo = _$_ScreenControllerBaseActionController.startAction(
        name: '_ScreenControllerBase.setErrorDisciplinas');
    try {
      return super.setErrorDisciplinas(msg);
    } finally {
      _$_ScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCreateDashBoardAsFalse() {
    final _$actionInfo = _$_ScreenControllerBaseActionController.startAction(
        name: '_ScreenControllerBase.setCreateDashBoardAsFalse');
    try {
      return super.setCreateDashBoardAsFalse();
    } finally {
      _$_ScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getHora(dynamic segundos) {
    final _$actionInfo = _$_ScreenControllerBaseActionController.startAction(
        name: '_ScreenControllerBase.getHora');
    try {
      return super.getHora(segundos);
    } finally {
      _$_ScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getData(dynamic epoch) {
    final _$actionInfo = _$_ScreenControllerBaseActionController.startAction(
        name: '_ScreenControllerBase.getData');
    try {
      return super.getData(epoch);
    } finally {
      _$_ScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
createDashBoard: ${createDashBoard},
selectedQuest: ${selectedQuest},
quizListIndex: ${quizListIndex},
errorDisciplinas: ${errorDisciplinas},
isLoading: ${isLoading},
errorFirebase: ${errorFirebase}
    ''';
  }
}