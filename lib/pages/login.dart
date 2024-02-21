
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/controller/auth.dart';

import '../app_config.dart';
import '../controller/shared_value.dart';
import '../my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui_widgets/drawer.dart';
import '../ui_widgets/my_app_bar.dart';


class Login extends StatefulWidget {
  Login({this.loginBy="firebase"}) : super();

  String loginBy;


  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login> {

  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  Future<void> mailAndPassSignIn() async{
    try{
        await Auth().mailAndPassSignIn(mail: _controllerEmail.text, pwd: _controllerPass.text);

    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
}

  Future<void> createUserWithMailAndPass() async{
    try{
      await Auth().createUserWithMailAndPass(mail: _controllerEmail.text, pwd: _controllerPass.text);

    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(title: AppLocalizations.of(context)!.login,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 40),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(
                        AppLocalizations.of(context)!.login,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        " " + AppConfig.app_name,
                        style: const TextStyle(
                          color: MyTheme.color_cyan,
                          fontSize: 20,
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    AppLocalizations.of(context)!.firebaseAuth,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(padding:
                const EdgeInsets.only(top: 40),
                child: TextField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,

                  ),
                ),
                ),
                Padding(padding:
                const EdgeInsets.only(top: 40),
                  child: TextField(
                    controller: _controllerPass,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.pass,

                    ),
                  ),
                ),
                Padding(padding:
                const EdgeInsets.only(top: 40),
                  child: Text(
                    errorMessage == '' ? '' : "Oops ? $errorMessage",
                  ),
                ),
                Padding(padding:
                const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: isLogin ? mailAndPassSignIn : createUserWithMailAndPass,
                    child: Text(
                      isLogin ? AppLocalizations.of(context)!.login : AppLocalizations.of(context)!.register  ,
                    ),
                  ),
                ),
                Padding(padding:
                const EdgeInsets.only(top: 40),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                      isLogin = !isLogin;
                    });
                    },
                    child: Text(
                      isLogin ? AppLocalizations.of(context)!.registerInstead : AppLocalizations.of(context)!.loginInstead,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
  
  
}
