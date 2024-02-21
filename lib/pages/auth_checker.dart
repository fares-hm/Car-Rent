import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_app/controller/shared_value.dart';
import 'package:photo_app/pages/home.dart';
import 'package:photo_app/pages/login.dart';
import 'package:photo_app/ui_widgets/my_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/auth.dart';

class AuthChcher extends StatefulWidget {
  const AuthChcher({Key? key}) : super(key: key);


  @override
  State<AuthChcher> createState() => _AuthChcherState();
}

class _AuthChcherState extends State<AuthChcher> {
  @override
  Widget build(BuildContext context) {

    // Check user firebase auth state

    return StreamBuilder(
        stream: Auth().authStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            saveLoginData();
            return const MyHomePage();
          } else {
            is_logged_in.$ = false;
            return Login();
          }
        });
  }

  // save user data to shared preferences
  void saveLoginData() {
    is_logged_in.$ = true;
    user_email.$ = Auth().currentUser?.email;
    user_id.$ = Auth().currentUser?.uid;
  }
  // clear user data from shared preferences

  void clearLoginData() {
    is_logged_in.$ = false;
    user_email.$ = "";
    user_id.$ = "";
  }
}
