import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc/firebaseHandlers.dart';

import 'package:tcc/mobx/conquistasController.dart';
import 'package:tcc/mobx/disciplinasController.dart';
import 'package:tcc/mobx/questsController.dart';
import 'package:tcc/mobx/quizController.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/mobx/assuntosController.dart';

import 'package:tcc/ui/dashboard.dart';
import 'package:tcc/ui/login.dart';
import 'package:tcc/widgets/loading.dart';

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InitialScreen.user = _auth.currentUser;
  final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.white));
  return runApp(MultiProvider(
    providers: [
      Provider<DisciplinasController>(create: (_) => DisciplinasController()),
      Provider<ConquistasController>(create: (_) => ConquistasController()),
      Provider<AssuntosController>(create: (_) => AssuntosController()),
      Provider<QuestsController>(create: (_) => QuestsController()),
      Provider<UserController>(create: (_) => UserController()),
      Provider<QuizController>(create: (_) => QuizController()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitialScreen(),
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white)),
          dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          bottomSheetTheme: BottomSheetThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)))),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.white,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
          scaffoldBackgroundColor: Colors.deepPurple,
          dividerColor: Colors.transparent,
          buttonColor: Colors.white,
          accentColor: Colors.white,
          cursorColor: Colors.white),
    ),
  ));
}

class InitialScreen extends StatelessWidget {
  static auth.User user;

  Widget build(BuildContext context) {
    final assuntosController = Provider.of<AssuntosController>(context);
    final conquistasController = Provider.of<ConquistasController>(context);
    final disciplinasController = Provider.of<DisciplinasController>(context);
    final questsController = Provider.of<QuestsController>(context);
    final quizController = Provider.of<QuizController>(context);
    final userController = Provider.of<UserController>(context);

    return FutureBuilder(
      future: getDisciplinas(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Loading();
        else {
          disciplinasController.addListOfDisciplinas(snapshot.data.docs);
          if (InitialScreen.user != null) {
            return FutureBuilder(
                future: Future.wait([
                  getAssuntos(),
                  getConquistas(),
                  getQuests(),
                  getQuizzes(),
                  getUserById(user.uid)
                ]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Loading();
                  } else {
                    assuntosController
                        .addListOfAsssuntos(snapshot.data[0].docs);
                    conquistasController
                        .addListOfConquistas(snapshot.data[1].docs);
                    questsController.addListOfQuests(snapshot.data[2].docs);
                    quizController.addListOfQuizzes(snapshot.data[3].docs);
                    userController.setUser(snapshot.data[4]);
                    return Dashboard();
                  }
                });
          } else {
            return Login();
          }
        }
      },
    );
  }
}
