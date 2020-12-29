import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider<DisciplinasController>(
          create: (_) => DisciplinasController(), lazy: false),
      Provider<ConquistasController>(
          create: (_) => ConquistasController(), lazy: false),
      Provider<AssuntosController>(
          create: (_) => AssuntosController(), lazy: false),
      Provider<QuestsController>(
          create: (_) => QuestsController(), lazy: false),
      Provider<UserController>(create: (_) => UserController(), lazy: false),
      Provider<QuizController>(create: (_) => QuizController(), lazy: false),
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
  static ValueNotifier<int> screenDataInt = ValueNotifier(0);

  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: InitialScreen.screenDataInt,
        builder: (ctx, value, child) {
          if (value >= 6) {
            if (InitialScreen.user != null) {
              return Dashboard();
            } else {
              return Login();
            }
          }
          return Loading();
        });
  }
}
