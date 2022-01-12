import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:a_la_vez/screens/login_page.dart';
import 'package:a_la_vez/screens/main_page.dart';
import 'package:a_la_vez/utils/util.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
        Icons.stream,
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
    if (allStorage != null) {
      allStorage.forEach((k, v) {
        if (kDebugMode) {
          print('k : $k, v : $v');
        }
        if (v == STATUS_LOGIN) statusUser = k;
      });
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    if (statusUser != null && statusUser != '') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(nickName: statusUser)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}