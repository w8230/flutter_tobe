import 'package:flutter/material.dart';
import 'package:devtobe/route/routing.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev TEST App.',
      theme: new ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          fontFamily: 'NanumGothic'
      ),
      routes:  routes,
    );
  }
}
