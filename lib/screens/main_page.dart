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
  int _selectValue = 1;
  DateTime _selectedTime = DateTime.now();

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
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context){
            return _writePost(context);
          }
        ),
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
    final _title = TextEditingController();
    final _context = TextEditingController();
    final _category = TextEditingController();

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
        _personnel(),
        // 마감 날짜
        _endDate(),
        const TextField(
          decoration: InputDecoration(label: Text("카테고리")),
          controller: null,
        ),
        Row(
          children: <Widget>[
            _writePostConfirm(_title.text, _context.text, _selectValue, _selectedTime, _category.text),
            _writePostCancel(),
          ],
        )
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

  // 인원
  StatefulBuilder _personnel(){
    List<int> _personnel = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setBottomSheetState) {
        return DropdownButton(
          value: _selectValue,
          items: _personnel.map((int value) {
            return DropdownMenuItem(
              value: value,
              child: Text("$value명"),
            );
          }).toList(),
          onChanged: (value) {
            setBottomSheetState(() {
              _selectValue = value as int;
            });
          },
        );
      }
    );
  }

  // 마감일
  StatefulBuilder _endDate(){
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setBottomSheetState){
        return ElevatedButton(
          onPressed: () {
            Future<DateTime?> selectedDate = showDatePicker(
              context: context,
              initialDate: DateTime.now(), // 초깃값
              firstDate: DateTime(DateTime.now().year), // 시작일
              lastDate: DateTime(DateTime.now().year + 5), // 마지막일
            );

            selectedDate.then((dateTime) {
              setBottomSheetState(() {
                if(dateTime != null){
                  _selectedTime = dateTime;
                }
                else{
                  throw Exception("dateTime is null");
                }
              });
            });
          },
          child: Text(_selectedTime.toString()),
        );
      }
    );
  }

  // 모집글 작성 확인 버튼
  TextButton _writePostConfirm(String title, String context, int personnel, DateTime endDate, String category){
    return TextButton(
      child: const Text("확인"),
      onPressed: (){
        
      },
    );
  }

  // 모집글 작성 취소 버튼
  TextButton _writePostCancel(){
    return TextButton(
      child: const Text("취소"),
      onPressed: () => Navigator.pop(context),
    );
  }
}