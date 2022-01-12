import 'dart:convert';

import 'package:a_la_vez/models/join.dto.dart';
import 'package:a_la_vez/models/reponse_join.dto.dart';
import 'package:http/http.dart' as http;

class RegisterPageService {
  Future<ResponseJoinDto> join(String url, JoinDto data, Map<String, String> headers) async {
    http.Response response = await http.post(
      Uri.parse(url), 
      headers: headers,
      body: json.encode(data.toJson()),
    );

    return ResponseJoinDto.fromJson(json.decode(response.body));
  }
}