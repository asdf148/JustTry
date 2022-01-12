import 'package:a_la_vez/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login_page.dart';

class MainPage extends StatefulWidget {
  String nickName;
  MainPage({Key? key, required this.nickName}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(nickName: nickName);
}

class _MainPageState extends State<MainPage> {
  final storage = const FlutterSecureStorage();
  String nickName;

  _MainPageState({required this.nickName});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Text(
            nickName == '' ? '' : 'Hello $nickName'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.keyboard_return_rounded),
        onPressed: () => _logout(),
      ),
    );
  }

  void _logout() async {
    Map<String, String> allStorage = await storage.readAll();
    allStorage.forEach((k, v) async {
      if (v == STATUS_LOGIN) {
        await storage.write(key: k, value: STATUS_LOGOUT);
      }
    });
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }
}