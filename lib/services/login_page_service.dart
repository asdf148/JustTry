import 'package:a_la_vez/models/login_dto.dart';
import 'package:a_la_vez/utils/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPageService{
  Future<void> login(String url, String email, String password) async {
    var dio = Dio();

    const storage = FlutterSecureStorage();
      
    try {
      var response = await dio.post(
        url,
        data: LoginDto(email: email, password: password).toJson(),
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
    
      print("응답 " + response.data["token"]);
      Map<String, String> allStorage = await storage.readAll();
      allStorage.forEach((k, v) async {
        print("$k : $v");
      });

      storage.write(key: TOKEN , value: response.data["token"]);

      // allStorage.forEach((k, v) {
      //   if (v == TOKEN){
      //     storage.write(key: response.data.toString(), value: TOKEN);
      //   }
      // });
    } 
    catch (e) {
      print(e);
      print("error occur");
      throw Exception(e);
    }

    return;
  }
}