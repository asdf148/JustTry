import 'package:a_la_vez/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login_page.dart';

class MainPage extends StatefulWidget {
  String nick;
  String email;

  MainPage({Key? key, required this.nick, required this.email}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(nick: nick, email: email);
}

class _MainPageState extends State<MainPage> {
  final storage = const FlutterSecureStorage(); // 로그아웃에 필요
  String nick;
  String email;

  _MainPageState({required this.nick, required this.email});

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
            nick == '' ? '' : 'Hello $nick'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => null,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // 프로젝트에 assets 폴더 생성 후 이미지 2개 넣기
            // pubspec.yaml 파일에 assets 주석에 이미지 추가하기
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                // 현재 계정 이미지 set
                backgroundImage: AssetImage('assets/default.png'),
                backgroundColor: Colors.white,
              ),
              accountName: Text(nick),
              accountEmail: Text(email),
              onDetailsPressed: () {
                print('arrow is clicked');
              },
              decoration: BoxDecoration(
                  color: Colors.red[200],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[850],
              ),
              title: Text('Home'),
              onTap: () {
                print('Home is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('Setting'),
              onTap: () {
                print('Setting is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.grey[850],
              ),
              title: const Text('Logout'),
              onTap: () {
                print("로그아웃");
                _logout();
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      )
    );
  }

  // 로그아웃
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