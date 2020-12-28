// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserController on UserControllerBase, Store {
  final _$usersMapAtom = Atom(name: 'UserControllerBase.usersMap');

  @override
  ObservableMap<dynamic, dynamic> get usersMap {
    _$usersMapAtom.reportRead();
    return super.usersMap;
  }

  @override
  set usersMap(ObservableMap<dynamic, dynamic> value) {
    _$usersMapAtom.reportWrite(value, super.usersMap, () {
      super.usersMap = value;
    });
  }

  final _$UserControllerBaseActionController =
      ActionController(name: 'UserControllerBase');

  @override
  dynamic updateUser(String field, dynamic value) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.updateUser');
    try {
      return super.updateUser(field, value);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToList(DocumentSnapshot item) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.addToList');
    try {
      return super.addToList(item);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usersMap: ${usersMap}
    ''';
  }
}
