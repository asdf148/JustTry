import 'package:a_la_vez/models/main_page_list_entity.dart';
import 'package:flutter/material.dart';

class MainPageListBody extends StatelessWidget {
  MainPageListEntity mainPageListEntity;

  MainPageListBody({Key? key, required this.mainPageListEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Text(mainPageListEntity.title),
          Text(mainPageListEntity.content,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}