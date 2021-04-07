// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assuntosController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AssuntosController on AssuntosControllerBase, Store {
  final _$assuntosMapAtom = Atom(name: 'AssuntosControllerBase.assuntosMap');

  @override
  ObservableMap<dynamic, dynamic> get assuntosMap {
    _$assuntosMapAtom.reportRead();
    return super.assuntosMap;
  }

  @override
  set assuntosMap(ObservableMap<dynamic, dynamic> value) {
    _$assuntosMapAtom.reportWrite(value, super.assuntosMap, () {
      super.assuntosMap = value;
    });
  }

  final _$AssuntosControllerBaseActionController =
      ActionController(name: 'AssuntosControllerBase');

  @override
  void addListOfAsssuntos(List<QueryDocumentSnapshot> assuntos) {
    final _$actionInfo = _$AssuntosControllerBaseActionController.startAction(
        name: 'AssuntosControllerBase.addListOfAsssuntos');
    try {
      return super.addListOfAsssuntos(assuntos);
    } finally {
      _$AssuntosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addToAssuntosMap(DocumentSnapshot item) {
    final _$actionInfo = _$AssuntosControllerBaseActionController.startAction(
        name: 'AssuntosControllerBase.addToAssuntosMap');
    try {
      return super.addToAssuntosMap(item);
    } finally {
      _$AssuntosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
assuntosMap: ${assuntosMap}
    ''';
  }
}
