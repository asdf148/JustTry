import 'package:a_la_vez/models/write_post_dto.dart';
import 'package:a_la_vez/models/writing.dart';
import 'package:dio/dio.dart';

class MainPageService{

    Future<void> wirtePost(String title, String context, int personnel, DateTime endDate, String category) async {

    WritePostDto writePostDto = WritePostDto(
      title: title, 
      content: context,
      personnel: personnel,
      endDate: endDate,
      category: category
    );

    var dio = Dio();
      
    try {
      Writing writing;

      var response = await dio.post(
        "https://qovh.herokuapp.com/post/write",
        data: writePostDto.toJson(),
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
    
      print("응답" + response.data.toString());

      writing = Writing.fromJson(response.data);
      
    } 
    catch (e) {
      print(e);
      print("error occur");
      throw Exception(e);
    }

    return;
  }
}