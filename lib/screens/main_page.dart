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
      // 메인 화면
      body: Center(
        child: Text(
            nick == '' ? '' : 'Hello $nick'),
      ),
      // 게시글 작성
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _writePost(context),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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

  Widget _writePost(BuildContext context) {
    List<int> _personnel = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    int _selectValue = 1;

    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(label: Text("제목")),
          controller: null,
        ),
        const TextField(
          decoration: InputDecoration(label: Text("내용")),
          controller: null,
        ),
        //인원
        DropdownButton(
          value: _selectValue,
          items: _personnel.map((int value) {
            return DropdownMenuItem(
              value: value,
              child: Text("$value명"),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectValue = value as int;
            });
          },
        ),
        const TextField(
          decoration: InputDecoration(label: Text("마감 일자")),
          controller: null,
        ),
        const TextField(
          decoration: InputDecoration(label: Text("카테고리")),
          controller: null,
        ),
      ],
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