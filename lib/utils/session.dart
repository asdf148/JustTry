import 'package:a_la_vez/services/register_page_service.dart';

class Session {
  Map<String, String> JSONheaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> JSONheadersWithToken (String token) {
    JSONheaders['Authorization'] = 'Bearer $token';
    return JSONheaders;
  }

  Map<String, String> cookies = {};

  RegisterPageService registerPageService= RegisterPageService();
}