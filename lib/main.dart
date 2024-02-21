import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/pages/auth_checker.dart';
import 'package:photo_app/pages/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_value/shared_value.dart';

import 'controller/shared_value.dart';

// This global SharedValue can be shared across the entire app
// IMPORTANT: Variable declared as final
final SharedValue<int> counter = SharedValue(
  // initial value
  value: 0,
);

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  is_logged_in.load();
  is_admin.load();
  user_id.load();
  //access_token.load();
  runApp(
    SharedValue.wrapApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}
class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'PhotoApp',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home:  const AuthChcher(),
    );
  }
}


