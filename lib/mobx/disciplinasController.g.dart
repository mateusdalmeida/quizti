// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disciplinasController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DisciplinasController on DisciplinasControllerBase, Store {
  final _$disciplinasMapAtom =
      Atom(name: 'DisciplinasControllerBase.disciplinasMap');

  @override
  ObservableMap<dynamic, dynamic> get disciplinasMap {
    _$disciplinasMapAtom.reportRead();
    return super.disciplinasMap;
  }

  @override
  set disciplinasMap(ObservableMap<dynamic, dynamic> value) {
    _$disciplinasMapAtom.reportWrite(value, super.disciplinasMap, () {
      super.disciplinasMap = value;
    });
  }

  final _$disciplinasListAtom =
      Atom(name: 'DisciplinasControllerBase.disciplinasList');

  @override
  ObservableList<dynamic> get disciplinasList {
    _$disciplinasListAtom.reportRead();
    return super.disciplinasList;
  }

  @override
  set disciplinasList(ObservableList<dynamic> value) {
    _$disciplinasListAtom.reportWrite(value, super.disciplinasList, () {
      super.disciplinasList = value;
    });
  }

  final _$DisciplinasControllerBaseActionController =
      ActionController(name: 'DisciplinasControllerBase');

  @override
  dynamic setDisciplinasList(List<dynamic> disciplinas) {
    final _$actionInfo = _$DisciplinasControllerBaseActionController
        .startAction(name: 'DisciplinasControllerBase.setDisciplinasList');
    try {
      return super.setDisciplinasList(disciplinas);
    } finally {
      _$DisciplinasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIsMatriculado(bool value, int index) {
    final _$actionInfo = _$DisciplinasControllerBaseActionController
        .startAction(name: 'DisciplinasControllerBase.changeIsMatriculado');
    try {
      return super.changeIsMatriculado(value, index);
    } finally {
      _$DisciplinasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addListOfDisciplinas(List<QueryDocumentSnapshot> disciplinas) {
    final _$actionInfo = _$DisciplinasControllerBaseActionController
        .startAction(name: 'DisciplinasControllerBase.addListOfDisciplinas');
    try {
      return super.addListOfDisciplinas(disciplinas);
    } finally {
      _$DisciplinasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToList(DocumentSnapshot item) {
    final _$actionInfo = _$DisciplinasControllerBaseActionController
        .startAction(name: 'DisciplinasControllerBase.addToList');
    try {
      return super.addToList(item);
    } finally {
      _$DisciplinasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
disciplinasMap: ${disciplinasMap},
disciplinasList: ${disciplinasList}
    ''';
  }
}
