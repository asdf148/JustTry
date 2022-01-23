import 'package:flutter/material.dart';

class MainPageListHeader extends StatefulWidget {
  @override
  _MainPageListHeaderState createState() => _MainPageListHeaderState();
}

class _MainPageListHeaderState extends State<MainPageListHeader>{
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 10.0,
      runSpacing: 10.0,
      children: [
        all(),
        project(),
        test(),
      ],
    );
  }

  Widget all(){
    return const TextButton(
      child: Text("All"),
      onPressed: null,
    );
  }

  Widget project(){
    return const TextButton(
      child: Text("프로젝트"),
      onPressed: null,
    );
  }

  Widget test(){
    return const TextButton(
      child: Text("Test"),
      onPressed: null,
    );
  }
}