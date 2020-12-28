// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rankingController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RankingController on _RankingControllerBase, Store {
  final _$testPointsAtom = Atom(name: '_RankingControllerBase.testPoints');

  @override
  int get testPoints {
    _$testPointsAtom.reportRead();
    return super.testPoints;
  }

  @override
  set testPoints(int value) {
    _$testPointsAtom.reportWrite(value, super.testPoints, () {
      super.testPoints = value;
    });
  }

  final _$rankingAtom = Atom(name: '_RankingControllerBase.ranking');

  @override
  ObservableList<dynamic> get ranking {
    _$rankingAtom.reportRead();
    return super.ranking;
  }

  @override
  set ranking(ObservableList<dynamic> value) {
    _$rankingAtom.reportWrite(value, super.ranking, () {
      super.ranking = value;
    });
  }

  final _$lastTestAtom = Atom(name: '_RankingControllerBase.lastTest');

  @override
  ObservableMap<dynamic, dynamic> get lastTest {
    _$lastTestAtom.reportRead();
    return super.lastTest;
  }

  @override
  set lastTest(ObservableMap<dynamic, dynamic> value) {
    _$lastTestAtom.reportWrite(value, super.lastTest, () {
      super.lastTest = value;
    });
  }

  final _$_RankingControllerBaseActionController =
      ActionController(name: '_RankingControllerBase');

  @override
  dynamic getRanking(dynamic context) {
    final _$actionInfo = _$_RankingControllerBaseActionController.startAction(
        name: '_RankingControllerBase.getRanking');
    try {
      return super.getRanking(context);
    } finally {
      _$_RankingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int getUserPontuation(dynamic runTests) {
    final _$actionInfo = _$_RankingControllerBaseActionController.startAction(
        name: '_RankingControllerBase.getUserPontuation');
    try {
      return super.getUserPontuation(runTests);
    } finally {
      _$_RankingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic calcTestPoints(Map<dynamic, dynamic> test, String tipo) {
    final _$actionInfo = _$_RankingControllerBaseActionController.startAction(
        name: '_RankingControllerBase.calcTestPoints');
    try {
      return super.calcTestPoints(test, tipo);
    } finally {
      _$_RankingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
testPoints: ${testPoints},
ranking: ${ranking},
lastTest: ${lastTest}
    ''';
  }
}
