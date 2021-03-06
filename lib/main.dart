import 'package:a_la_vez/services/login_page_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:a_la_vez/screens/login_page.dart';
import 'package:a_la_vez/screens/main_page.dart';
import 'package:a_la_vez/utils/util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ko', 'KO'),
      ],
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => _checkUser(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Icon(
        Icons.directions_run_sharp,
        size: 80,
        color: Colors.blue,
      )),
    );
  }

  void _checkUser(context) async {
    const storage = FlutterSecureStorage();
    if (kDebugMode) {
      print('${await storage.readAll()}');
    }
    Map<String, String> allStorage = await storage.readAll();
    String statusUser = '';
    String email = '';
    String password = '';
    if (allStorage != null) {
      allStorage.forEach((k, v) {
        if (kDebugMode) {
          print('k : $k, v : $v');
        }
        if (v == STATUS_LOGIN){
          List<String> user = k.split("{<>}");

          statusUser = user[0];
          email = user[1];
          password = user[2];
        }
      });
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    if (statusUser != null && statusUser != "" && email != "") {
      //????????? api ??????
      await LoginPageService().login("https://qovh.herokuapp.com/auth/login", email, password);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(nick: statusUser, email: email,)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}