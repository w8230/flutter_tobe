import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:devtobe/widget/painter/widget/board_widget.dart';
import 'package:devtobe/widget/painter/widget/menu_widget.dart';
import 'package:devtobe/widget/drawer.dart';

class Painter extends StatefulWidget {
  Painter({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<Painter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
        padding: const EdgeInsets.all(8.0),
          child: Text(
            "이미지 편집",
            style: TextStyle(fontSize: 15, fontFamily: 'NanumGothic'),
            textAlign: TextAlign.center,
          ),
      ),),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            BoardWdiget(),
            Positioned(
              right: 0,
              child: MenuWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
