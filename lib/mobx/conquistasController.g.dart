// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conquistasController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConquistasController on ConquistasControllerBase, Store {
  final _$conquistasMapAtom =
      Atom(name: 'ConquistasControllerBase.conquistasMap');

  @override
  ObservableMap<dynamic, dynamic> get conquistasMap {
    _$conquistasMapAtom.reportRead();
    return super.conquistasMap;
  }

  @override
  set conquistasMap(ObservableMap<dynamic, dynamic> value) {
    _$conquistasMapAtom.reportWrite(value, super.conquistasMap, () {
      super.conquistasMap = value;
    });
  }

  final _$ConquistasControllerBaseActionController =
      ActionController(name: 'ConquistasControllerBase');

  @override
  void addToList(DocumentSnapshot item) {
    final _$actionInfo = _$ConquistasControllerBaseActionController.startAction(
        name: 'ConquistasControllerBase.addToList');
    try {
      return super.addToList(item);
    } finally {
      _$ConquistasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addListOfConquistas(List<QueryDocumentSnapshot> conquistas) {
    final _$actionInfo = _$ConquistasControllerBaseActionController.startAction(
        name: 'ConquistasControllerBase.addListOfConquistas');
    try {
      return super.addListOfConquistas(conquistas);
    } finally {
      _$ConquistasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic runConquistas(dynamic userData, dynamic uid, {dynamic lastTest}) {
    final _$actionInfo = _$ConquistasControllerBaseActionController.startAction(
        name: 'ConquistasControllerBase.runConquistas');
    try {
      return super.runConquistas(userData, uid, lastTest: lastTest);
    } finally {
      _$ConquistasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
conquistasMap: ${conquistasMap}
    ''';
  }
}
