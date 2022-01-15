import 'dart:io';

import 'package:a_la_vez/models/join.dto.dart';
import 'package:a_la_vez/models/reponse_join.dto.dart';
import 'package:a_la_vez/utils/session.dart';
import 'package:a_la_vez/utils/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'login_page.dart';
import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  late XFile _userFileCtrl;
  late TextEditingController _userNickNameCtrl;
  late TextEditingController _userEmailCtrl;
  late TextEditingController _userPasswordCtrl;

  @override
  void initState() {
    super.initState();
    _userNickNameCtrl = TextEditingController(text: '');
    _userEmailCtrl = TextEditingController(text: '');
    _userPasswordCtrl = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
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
              _fileWidget(),
              const SizedBox(
                height: 8,
              ),
              _nickNameWidget(),
              const SizedBox(
                height: 8,
              ),
              _emailWidget(),
              const SizedBox(
                height: 8,
              ),
              _passwordWidget(),
              _joinButton(context),
              _loginButton(context),
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fileWidget(){
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    return FloatingActionButton(
      child: const Text("select file"),
      onPressed: ()  async {
        print('사진추가');
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

        if(image != null) {
          _userFileCtrl = image;
        } else {
          // User canceled the picker
        }
      },
    );
  }

  Widget _nickNameWidget() {
    return TextFormField(
      controller: _userNickNameCtrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle_rounded),
        labelText: "NickName",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _emailWidget() {
    return TextFormField(
      controller: _userEmailCtrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.email,
        ),
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

  Widget _joinButton(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
          padding: const EdgeInsets.all(8.0),
        ),
        onPressed: () {
          isLoading ? null : _registCheck();
        },
        child: Text(
          isLoading ? 'Regist in.....' : 'Regist',
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
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
        onPressed: () => isLoading
            ? null
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage(),
                ),
              ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _registCheck() async {
    const storage = FlutterSecureStorage();
    if (kDebugMode) {
      print(' ');
      print('await storage.readAll() : ');
      print(await storage.readAll());
      print(' ');
    }
    //--------------------------------------------
    ResponseJoinDto responseJoinDto = ResponseJoinDto.empty();
    try{
      responseJoinDto = await Session().registerPageService.postFile(
        "https://qovh.herokuapp.com/auth/join",
        _userFileCtrl,
        _userNickNameCtrl.text,
        _userEmailCtrl.text,
        _userPasswordCtrl.text
      );
    }catch(e){
      print(e);
      return;
    }
    print("-----------------------in screen-----------------------");
    print(responseJoinDto);
    print(responseJoinDto.id);
    print(responseJoinDto.nick);
    print(responseJoinDto.email);
    print(responseJoinDto.imagePath);
    //--------------------------------------------
    String userNickName = _userNickNameCtrl.text;
    String userEmail = _userEmailCtrl.text;
    String userPassword = _userPasswordCtrl.text;
    if (userNickName != '' && userEmail != '' && userPassword != '') {
      String emailCheck = await storage.read(key: userEmail);
      if (emailCheck == null) {
        storage.write(key: userEmail, value: userPassword);
        storage.write(key: '${userEmail}_$userPassword', value: userNickName);
        storage.write(key: userNickName, value: STATUS_LOGIN);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => MainPage(nickName: userNickName,)));
      } else {
        showToast('email이 중복됩니다.');
      }
    } else {
      showToast("입력란을 모두 채워주세요.");
    }
  }
}