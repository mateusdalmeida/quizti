import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/userController.dart';
part 'rankingController.g.dart';

class RankingController = _RankingControllerBase with _$RankingController;

abstract class _RankingControllerBase with Store {
  @observable
  int testPoints = 0;

  @observable
  ObservableList ranking = ObservableList();

  @observable
  ObservableMap lastTest = ObservableMap();

  @action
  getRanking(context) {
    final userController = Provider.of<UserController>(context);
    userController.usersMap.forEach((key, value) {
      if (value['tipo'] == "aluno") {
        Map temp = {};
        temp["points"] = 0;
        temp['name'] = value['name'];
        temp['id'] = key;
        if (value['runTests'] != null) {
          value['runTests'].forEach((runTests) {
            temp["points"] += calcTestPoints(runTests['quest'], "multi");
          });
        }
        ranking.add(temp);
      }
    });
    ranking.sort((m1, m2) {
      var r = m2["points"].compareTo(m1["points"]);
      return r;
    });
  }

  @action
  int getUserPontuation(runTests) {
    int points = 0;
    runTests.forEach((runTests) {
      points += calcTestPoints(runTests['quest'], "multi");
    });
    return points;
  }

  @action
  calcTestPoints(Map test, String tipo) {
    int points = 0;
    int acertos = 0;
    int solved = 0;
    int time = 0;

    test.forEach((key, value) {
      solved++;
      if (value['result']) acertos++;
      time += value['time'];
    });
    //REGRA DE PONTUAÇÃO
    // 1 PONTO POR PARTICIPAÇÃO
    // 1 PONTO POR ACERTOS
    // SE GABARITAR GANHA 3 PONTOS
    if (acertos == 0) {
      points = 1;
    } else if (acertos < 6) {
      points = acertos + 1;
    } else {
      points = 10;
    }

    if (tipo == 'single') {
      lastTest["solved"] = solved;
      lastTest["acertos"] = acertos;
      lastTest["time"] = time;
      testPoints = points;
    }

    if (tipo == "multi") {
      return points;
    }
  }
}
