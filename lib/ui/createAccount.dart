import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/ui/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tcc/mobx/disciplinasController.dart';
import 'package:tcc/mobx/screenController.dart';
import 'package:tcc/main.dart';
import 'package:tcc/widgets/loadingButton.dart';

final db = FirebaseFirestore.instance;

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _radioValue;
  @override
  Widget build(BuildContext context) {
    final disciplinasController = Provider.of<DisciplinasController>(context);
    final screenController = Provider.of<ScreenController>(context);
    final userController = Provider.of<UserController>(context);
    disciplinasController.setDisciplinasList([]);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Observer(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: "createAccountText",
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text("Criar Usuario",
                            style:
                                TextStyle(color: Colors.white, fontSize: 40)),
                      ),
                    ),
                    Divider(),
                    textField(nameController, "Nome", Icons.person_outline,
                        !screenController.isLoading),
                    Divider(),
                    textField(emailController, "Email", Icons.alternate_email,
                        !screenController.isLoading,
                        keyboardType: TextInputType.emailAddress),
                    Divider(),
                    textField(ageController, "Idade", Icons.today,
                        !screenController.isLoading,
                        keyboardType: TextInputType.number),
                    Divider(),
                    textField(passwordController, "Senha", Icons.lock_outline,
                        !screenController.isLoading,
                        obscure: true),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text("Sexo",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          groupValue: _radioValue,
                          value: 0,
                          onChanged: screenController.isLoading
                              ? null
                              : (i) => setState(() => _radioValue = i),
                        ),
                        Text("Feminino",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          groupValue: _radioValue,
                          value: 1,
                          onChanged: screenController.isLoading
                              ? null
                              : (i) => setState(() => _radioValue = i),
                        ),
                        Text("Masculino",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                        title: Text(
                          "Escolher Disciplinas",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        children: List.generate(
                            disciplinasController.disciplinasList.length,
                            (index) {
                          return Observer(builder: (context) {
                            if (disciplinasController.disciplinasList[index]
                                    ['nome'] ==
                                "Testes") return SizedBox();
                            return CheckboxListTile(
                              checkColor: Colors.deepPurple,
                              title: Text(
                                  disciplinasController.disciplinasList[index]
                                      ['nome'],
                                  style: TextStyle(color: Colors.white)),
                              value: disciplinasController
                                  .disciplinasList[index]['isMatriculado'],
                              onChanged: screenController.isLoading
                                  ? null
                                  : (bool value) {
                                      disciplinasController.changeIsMatriculado(
                                          value, index);
                                    },
                            );
                          });
                        })),
                    Center(
                        child: Text(screenController.errorDisciplinas,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold))),
                    Center(
                        child: Text(screenController.errorFirebase,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold))),
                    Hero(
                      tag: "heroDashboard",
                      child: RaisedButton(
                        child: LoadingButton("Criar Conta"),
                        onPressed: screenController.isLoading
                            ? null
                            : () {
                                List disciplinas = List();
                                disciplinasController.disciplinasList
                                    .forEach((el) {
                                  if (el['isMatriculado'])
                                    disciplinas.add(el['id']);
                                });
                                if (disciplinas.length == 0) {
                                  screenController.setErrorDisciplinas(
                                      "Escolha uma disciplina");
                                } else {
                                  screenController.setErrorDisciplinas("");
                                }
                                if (_formKey.currentState.validate() &&
                                    disciplinas.length != 0) {
                                  screenController.isLoadingChange(true);
                                  _register(userController, screenController,
                                      disciplinas);
                                }
                              },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(controller, name, icon, enabled,
      {obscure = false, TextInputType keyboardType}) {
    return TextFormField(
        enabled: enabled,
        controller: controller,
        decoration: InputDecoration(
          labelText: name,
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        style: TextStyle(color: Colors.white),
        obscureText: obscure,
        validator: (value) {
          if (value.isEmpty) return name + " em branco";
          return null;
        },
        keyboardType: keyboardType);
  }

  void _register(userController, screenController, List disciplinas) async {
    print(emailController.text);
    try {
      final auth.User user = (await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;
      if (user != null) {
        InitialScreen.user = user;
        await db.collection("users").doc(user.uid).set({
          'name': nameController.text,
          'age': ageController.text,
          'sexo': _radioValue,
          'tipo': 'aluno',
          'disciplinas': disciplinas
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
        screenController.isLoadingChange(false);
        screenController.changeErrorFirebase("");
      }
    } catch (e) {
      print(e.message);
      print("erro");
      screenController.isLoadingChange(false);
      screenController.changeErrorFirebase(e.message);
    }
  }
}