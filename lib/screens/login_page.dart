import 'package:a_la_vez/screens/register_page.dart';
import 'package:a_la_vez/utils/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  late TextEditingController _userEmailCtrl;
  late TextEditingController _userPasswordCtrl;

  @override
  void initState() {
    super.initState();
    _userEmailCtrl = TextEditingController(text: '');
    _userPasswordCtrl = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              _emailWidget(),
              const SizedBox(
                height: 8,
              ),
              _passwordWidget(),
              _loginButton(context),
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailWidget() {
    return TextFormField(
      controller: _userEmailCtrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: _userPasswordCtrl,
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key_rounded),
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _loginButton(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
          padding: const EdgeInsets.all(8.0),
        ),
        onPressed: () => isLoading ? null : _loginCheck(),
        child: Text(
          isLoading ? 'loggin in.....' : 'login',
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Don\'t have an account ?'),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPage())),
          child: const Text('register'),
        ),
      ],
    );
  }

  void _loginCheck() async {
    if (kDebugMode) {
      print('_userEmailCtrl.text : ${_userEmailCtrl.text}');
      print('_userPasswordCtrl.text : ${_userPasswordCtrl.text}');
    }
    final storage = FlutterSecureStorage();
    String storagePass = await storage.read(key: _userEmailCtrl.text);
    if(storagePass != null && storagePass != '' && storagePass == _userPasswordCtrl.text){
      if (kDebugMode) {
        print('storagePass : $storagePass');
      }
      String userNickName = await storage.read(key: '${_userEmailCtrl.text}_$storagePass');
      storage.write(key: userNickName, value: STATUS_LOGIN);
      if (kDebugMode) {
        print('로그인 성공');
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainPage(nickName: userNickName)));
    } else {
      if (kDebugMode) {
        print('로그인 실패');
      }
      showToast('아이디가 존재하지 않거나 비밀번호가 맞지않습니다.');
    }
  }
}