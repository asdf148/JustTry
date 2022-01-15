import 'dart:convert';
import 'dart:io';

import 'package:a_la_vez/models/join.dto.dart';
import 'package:a_la_vez/models/reponse_join.dto.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RegisterPageService {

  // 안씀
  Future<ResponseJoinDto> join(String url, JoinDto data, Map<String, String> headers) async {
    http.Response response = await http.post(
      Uri.parse(url), 
      headers: headers,
      body: json.encode(data.toJson()),
    );

    return ResponseJoinDto.fromJson(json.decode(response.body));
  }

  //안씀
  Future<void> httpJoin(String url, XFile file, String nick, String email, String password) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields["nick"] = nick;
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["re_password"] = password;
    request.files.add(await http.MultipartFile.fromPath("file", file.path));

    request.send().then((response) async {
      print(response.statusCode);
      print(await response.stream.bytesToString());
    });

    // return ResponseJoinDto.fromJson(json.decode(response.body));
  }
  
  Future<ResponseJoinDto> postFile(String url, XFile file, String nick, String email, String password) async {

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
      "nick": nick,
      "email": email,
      "password": password,
      "re_password": password
    });

    var dio = Dio();

    ResponseJoinDto responseJoinDto;
      
    try {
      var response = await dio.post(
        url,
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
    
      print("응답" + response.data.toString());

      responseJoinDto = ResponseJoinDto.fromJson(response.data["user"]);
      
    } 
    catch (e) {
      print(e);
      print("error occur");
      responseJoinDto = ResponseJoinDto.empty();
      throw Exception(e);
    }

    return responseJoinDto;
  }
}