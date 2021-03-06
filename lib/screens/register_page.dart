import 'package:a_la_vez/models/reponse_join_dto.dart';
import 'package:a_la_vez/services/login_page_service.dart';
import 'package:a_la_vez/utils/session.dart';
import 'package:a_la_vez/utils/util.dart';
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
    return ElevatedButton(
      child: const Text("select file"),
      onPressed: ()  async {
        print('????????????');
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
    //--------------------------------------------
    String userNickName = _userNickNameCtrl.text;
    String userEmail = _userEmailCtrl.text;
    String userPassword = _userPasswordCtrl.text;
    if (userNickName != '' && userEmail != '' && userPassword != '') {
      String emailCheck = await storage.read(key: userEmail);
      if (emailCheck == null) {
        storage.write(key: userEmail, value: userPassword);
        storage.write(key: '${userEmail}_$userPassword', value: userNickName);
        //????????? api ??????
      await LoginPageService().login("https://qovh.herokuapp.com/auth/login", _userEmailCtrl.text, _userPasswordCtrl.text);
        storage.write(key: '$userNickName{<>}$userEmail{<>}$userPassword', value: STATUS_LOGIN);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => MainPage(nick: userNickName, email:userEmail)));
      } else {
        showToast('email??? ???????????????.');
      }
    } else {
      showToast("???????????? ?????? ???????????????.");
    }
  }
}