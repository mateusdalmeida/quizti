import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/screenController.dart';
import 'package:tcc/mobx/userController.dart';
import 'package:tcc/ui/createAccount.dart';
import 'package:tcc/ui/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tcc/main.dart';
import 'package:tcc/widgets/loadingButton.dart';

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State {
  TextEditingController emailController = TextEditingController();
  TextEditingController emailRecoveryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formRecoveryKey = GlobalKey<FormState>();

  final screenController = ScreenController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Observer(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Login",
                        style: TextStyle(color: Colors.white, fontSize: 40)),
                    Divider(),
                    TextFormField(
                      enabled: !screenController.isLoading,
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon:
                              Icon(Icons.alternate_email, color: Colors.white)),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) return "Email não digitado";
                        return null;
                      },
                    ),
                    Divider(),
                    TextFormField(
                      enabled: !screenController.isLoading,
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          prefixIcon:
                              Icon(Icons.lock_outline, color: Colors.white)),
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) return "Senha não digitada";
                        return null;
                      },
                    ),
                    Divider(),
                    screenController.errorFirebase == ''
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Center(
                              child: Text(screenController.errorFirebase,
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                    Hero(
                      tag: "heroDashboard",
                      child: LoadingButton(
                        label: "Entrar",
                        onPressed: screenController.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState.validate()) {
                                  screenController.setIsLoading(true);
                                  await _signInWithEmailAndPassword(
                                      userController, screenController);
                                }
                              },
                      ),
                    ),
                    Divider(),
                    RaisedButton(
                      child: Hero(
                          tag: "createAccountText",
                          child: Material(
                              type: MaterialType.transparency,
                              child: Text("Criar Usuario",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                      onPressed: screenController.isLoading
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateAccount()));
                            },
                    ),
                    Divider(),
                    Divider(),
                    GestureDetector(
                      child: Center(
                          child: Text("Esqueci minha senha",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15))),
                      onTap: screenController.isLoading
                          ? null
                          : () {
                              _showModalSheet();
                            },
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  _signInWithEmailAndPassword(
      userController, ScreenController screenController) async {
    try {
      final auth.User user = (await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;
      if (user != null) {
        InitialScreen.user = user;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
    } catch (e) {
      print(e.message);
      print("erro");
      screenController.setIsLoading(false);
      screenController.setErrorFirebase(e.message);
    }
  }

  void _showModalSheet() {
    final OutlineInputBorder recoveryBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.deepPurple));
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Form(
                key: _formRecoveryKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Recuperar Senha",
                        style:
                            TextStyle(fontSize: 35, color: Colors.deepPurple)),
                    Divider(),
                    TextFormField(
                      autofocus: true,
                      controller: emailRecoveryController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Colors.deepPurple,
                        ),
                        enabledBorder: recoveryBorder,
                        focusedBorder: recoveryBorder,
                      ),
                      style: TextStyle(color: Colors.deepPurple),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) return "Email não digitado";
                        return null;
                      },
                    ),
                    Divider(),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.infinity,
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Text("Enviar"),
                      onPressed: () async {
                        if (_formRecoveryKey.currentState.validate()) {
                          await _auth.sendPasswordResetEmail(
                            email: emailRecoveryController.text,
                          );
                          Navigator.pop(context);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Recuperação enviada por email')));
                          emailRecoveryController.text = "";
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
