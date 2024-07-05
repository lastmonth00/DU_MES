import 'package:flutter/material.dart';

Map<String, Object?> castMap(Map<String, dynamic> data) {
  Map<String, Object?> rtn = {};
  data.forEach((key, value) => rtn[key] = value);
  return rtn;
}

List<Map<String, Object?>> castListMap(List<dynamic> list) {
  List<Map<String, Object?>> temp = [];
  for (Map<String, dynamic> item in list) {
    temp.add(castMap(item));
  }
  return temp;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MES',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //   home: HomePage(),
    );
  }
}
