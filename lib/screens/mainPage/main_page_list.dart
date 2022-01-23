import 'package:a_la_vez/models/main_page_list_entity.dart';
import 'package:a_la_vez/screens/mainPage/main_page_list_body.dart';
import 'package:flutter/material.dart';

class MainPageList{
  Widget mainPageList(List<MainPageListEntity> mainPageListEntities){
    return ListView.builder(
      itemCount: mainPageListEntities.length,
      itemBuilder: (BuildContext context, int index){
        return MainPageListBody(mainPageListEntity: mainPageListEntities[index]);
      }
    );
  }
}