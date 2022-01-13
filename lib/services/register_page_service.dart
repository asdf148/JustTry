import 'dart:convert';
import 'dart:io';

import 'package:a_la_vez/models/join.dto.dart';
import 'package:a_la_vez/models/reponse_join.dto.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RegisterPageService {
  Future<ResponseJoinDto> join(String url, JoinDto data, Map<String, String> headers) async {
    http.Response response = await http.post(
      Uri.parse(url), 
      headers: headers,
      body: json.encode(data.toJson()),
    );

    return ResponseJoinDto.fromJson(json.decode(response.body));
  }
  // 400 뜬다
  postFile(String url, XFile file, String nick, String email, String password) async {

    FormData formData = FormData.fromMap({
      "filename": await MultipartFile.fromFile(file.path),
      "nick": nick,
      "email": email,
      "password": password,
      "re_password": password
    });

    var dio = Dio();
      
    try {
      var response = await dio.post(
        url,
        data: formData,
      );
    
      print("응답" + response.data.toString());
    } 
    catch (e) {
      print(e);
      print("error occur");
    }
  }
}