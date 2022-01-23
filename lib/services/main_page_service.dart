import 'package:a_la_vez/models/write_post_dto.dart';
import 'package:a_la_vez/models/writing_with_user.dart';
import 'package:a_la_vez/utils/util.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class MainPageService{

    Future<void> wirtePost(XFile file, String title, String context, int personnel, DateTime endDate, String category) async {

    var storage = const FlutterSecureStorage();

    String token = "";

    token = await storage.read(key: TOKEN);

    Dio.FormData formData = Dio.FormData.fromMap({
      "file": await Dio.MultipartFile.fromFile(file.path),
      "title": title,
      "content": context,
      "personnel": personnel,
      "endDate": endDate,
      "category": category
    });

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
        data: formData,
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

    writing = WritingWithUser.fromJson(response.data["writing"]);
      
    } 
    catch (e) {
      print(e);
      print("error occur");
      throw Exception(e);
    }

    return;
  }
}