import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'conquistasController.g.dart';

class ConquistasController = ConquistasControllerBase
    with _$ConquistasController;
final db = FirebaseFirestore.instance;

abstract class ConquistasControllerBase with Store {
  // ConquistasControllerBase() {
  //   db
  //       .collection("conquistas")
  //       .orderBy("order", descending: true)
  //       .snapshots()
  //       .forEach((docs) {
  //     docs.docChanges.reversed.forEach((changes) {
  //       switch (changes.type) {
  //         case DocumentChangeType.removed:
  //           break;
  //         default:
  //           addToList(changes.doc);
  //           break;
  //       }
  //     });
  //     InitialScreen.screenDataInt.value++;
  //   });
  // }

  @observable
  ObservableMap conquistasMap = ObservableMap();

  @action
  void addToList(DocumentSnapshot item) {
    conquistasMap[item.id] = item.data();
  }

  @action
  void addListOfConquistas(List<QueryDocumentSnapshot> conquistas) {
    conquistas.forEach((item) {
      conquistasMap[item.id] = item.data();
    });
  }

  @action
  runConquistas(userData, uid, {lastTest}) {
    List conquistas = userData['conquistas'];
    if (conquistas == null) conquistas = [];
    List runTests = userData['runTests'];
    if (runTests == null) runTests = [];
    List<String> newConquistas = [];
    List<String> solvedQuests = [];
    List<String> acertsQuests = [];

    //codigo da gambi
    if (lastTest != null) runTests.add(lastTest);

    int gabaritou = 0;
    int naTrave = 0;
    int ligeirinho = 0;
    int chute = 0;
    int errouTodas = 0;

    runTests.forEach((quiz) {
      int acertos = 0;
      int time = 0;
      quiz['quest'].forEach((key, value) {
        if (!solvedQuests.contains(key)) solvedQuests.add(key);
        if (value['result'] && !acertsQuests.contains(key))
          acertsQuests.add(key);

        if (value['result']) acertos++;
        time += value['time'];
      });

      if (time < 30) {
        ligeirinho++;
        if (acertos == quiz['quest'].length) {
          chute++;
        }
      }
      if (acertos == quiz['quest'].length) gabaritou++;
      if (acertos == (quiz['quest'].length - 1)) naTrave++;
      if (acertos == 0) errouTodas++;
    });

    //------------------------------------------------------------------------
    //resolva 1 quiz
    if (!conquistas.contains("Wwii3341v8LnYvQbiyiy")) {
      if (runTests.length >= 1) {
        newConquistas.add("Wwii3341v8LnYvQbiyiy");
      }
    }
    //resolva 50 quiz
    if (!conquistas.contains("6UU0w75V93y3O4PJJDAV")) {
      if (runTests.length >= 50) {
        newConquistas.add("6UU0w75V93y3O4PJJDAV");
      }
    }
    //resolva 100 quiz
    if (!conquistas.contains("5PcScflihda0nIjMSeGe")) {
      if (runTests.length >= 100) {
        newConquistas.add("5PcScflihda0nIjMSeGe");
      }
    }

    //------------------------------------------------------------------------
    //gabarite 1 quiz
    if (!conquistas.contains("Ly7sTwZ0mgciwiX3aPag")) {
      if (gabaritou >= 1) {
        newConquistas.add("Ly7sTwZ0mgciwiX3aPag");
      }
    }
    //gabarite 15 quiz
    if (!conquistas.contains("7ivBMDS1ZIJQwoRooTPM")) {
      if (gabaritou >= 15) {
        newConquistas.add("7ivBMDS1ZIJQwoRooTPM");
      }
    }
    //gabarite 30 quiz
    if (!conquistas.contains("rjIILNeACQ33kXWY3FMq")) {
      if (gabaritou >= 30) {
        newConquistas.add("rjIILNeACQ33kXWY3FMq");
      }
    }

    //------------------------------------------------------------------------
    //naTrave 1 quiz
    if (!conquistas.contains("rOgK88rU8D2JiHRUgLAF")) {
      if (naTrave >= 1) {
        newConquistas.add("rOgK88rU8D2JiHRUgLAF");
      }
    }
    //naTrave 15 quiz
    if (!conquistas.contains("zJP9QM7jSbBJilyAm6Gu")) {
      if (naTrave >= 15) {
        newConquistas.add("zJP9QM7jSbBJilyAm6Gu");
      }
    }
    //naTrave 30 quiz
    if (!conquistas.contains("KowL79gvSh3CuvYfonzK")) {
      if (naTrave >= 30) {
        newConquistas.add("KowL79gvSh3CuvYfonzK");
      }
    }

    //------------------------------------------------------------------------
    //erre todas as questoes 1 quiz
    if (!conquistas.contains("ATAOyy6ZXX54JgZUSl6a")) {
      if (errouTodas >= 1) {
        newConquistas.add("ATAOyy6ZXX54JgZUSl6a");
      }
    }
    //erre todas as questoes 15 quiz
    if (!conquistas.contains("asbomSzAFEKxEQgSEzF9")) {
      if (errouTodas >= 15) {
        newConquistas.add("asbomSzAFEKxEQgSEzF9");
      }
    }
    //erre todas as questoes 30 quiz
    if (!conquistas.contains("Ouim9E2jRyzcWqIb8uIG")) {
      if (errouTodas >= 30) {
        newConquistas.add("Ouim9E2jRyzcWqIb8uIG");
      }
    }

    //------------------------------------------------------------------------
    //ligeirinho 1 quiz
    if (!conquistas.contains("SkZaLZ8iXz0Kh5w5Ulsd")) {
      if (ligeirinho >= 1) {
        newConquistas.add("SkZaLZ8iXz0Kh5w5Ulsd");
      }
    }
    //ligeirinho 15 quiz
    if (!conquistas.contains("77jI03iQPK6HXJPs96xk")) {
      if (ligeirinho >= 15) {
        newConquistas.add("77jI03iQPK6HXJPs96xk");
      }
    }
    //ligeirinho 30 quiz
    if (!conquistas.contains("7hiMtPIEL3FqevK1ZaSo")) {
      if (ligeirinho >= 30) {
        newConquistas.add("7hiMtPIEL3FqevK1ZaSo");
      }
    }

    //------------------------------------------------------------------------
    //resolva 15 questoes diferentes
    if (!conquistas.contains("2GIwcyWSnMrtuuZg9hz7")) {
      if (solvedQuests.length >= 15) {
        newConquistas.add("2GIwcyWSnMrtuuZg9hz7");
      }
    }
    //resolva 50 questoes diferentes
    if (!conquistas.contains("b51IiATJnNkE08ciu8Dc")) {
      if (solvedQuests.length >= 50) {
        newConquistas.add("b51IiATJnNkE08ciu8Dc");
      }
    }
    //resolva 100 questoes diferentesz
    if (!conquistas.contains("cpSAbK8VQV7pr7rSGqdr")) {
      if (solvedQuests.length >= 100) {
        newConquistas.add("cpSAbK8VQV7pr7rSGqdr");
      }
    }

    //------------------------------------------------------------------------
    //acerte 15 questoes diferentes
    if (!conquistas.contains("baw8BL0kQapkzVjqryoP")) {
      if (acertsQuests.length >= 15) {
        newConquistas.add("baw8BL0kQapkzVjqryoP");
      }
    }
    //acerte 50 questoes diferentes
    if (!conquistas.contains("C1bqufPziS6VwV3jPASc")) {
      if (acertsQuests.length >= 50) {
        newConquistas.add("C1bqufPziS6VwV3jPASc");
      }
    }
    //acerte 100 questoes diferentes
    if (!conquistas.contains("XJRBHLLNeUzxqRBGwMsq")) {
      if (acertsQuests.length >= 100) {
        newConquistas.add("XJRBHLLNeUzxqRBGwMsq");
      }
    }

    //------------------------------------------------------------------------
    //bom de chute
    if (!conquistas.contains("Ir0BnfQdL7b91TopRWVh")) {
      if (chute >= 1) {
        newConquistas.add("Ir0BnfQdL7b91TopRWVh");
      }
    }

    db
        .collection("users")
        .doc(uid)
        .update({'conquistas': FieldValue.arrayUnion(newConquistas)});
    for (var item in newConquistas) {
      db
          .collection("conquistas")
          .doc(item)
          .update({'realizaram': FieldValue.increment(1)});
    }

    return newConquistas;
  }
}
