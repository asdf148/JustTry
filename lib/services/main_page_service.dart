import 'package:a_la_vez/models/write_post_dto.dart';
import 'package:a_la_vez/models/writing_with_user.dart';
import 'package:a_la_vez/utils/util.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainPageService{

    Future<void> wirtePost(String title, String context, int personnel, DateTime endDate, String category) async {

    var storage = const FlutterSecureStorage();

    String token = "";

    token = await storage.read(key: TOKEN);

    WritePostDto writePostDto = WritePostDto(
      title: title, 
      content: context,
      personnel: personnel,
      endDate: endDate,
      category: category
    );

    var dio = Dio.Dio();
      
    try {
      WritingWithUser writing;

      var response = await dio.post(
        "https://qovh.herokuapp.com/post/write",
        data: writePostDto.toJson(),
        options: Dio.Options(
          headers: {
            "authorization" : "Bearer $token",
          }
        ),
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
    
      print("응답" + response.data.toString());

      writing = WritingWithUser.fromJson(response.data);
      
    } 
    catch (e) {
      print(e);
      print("error occur");
      throw Exception(e);
    }

    return;
  }
}