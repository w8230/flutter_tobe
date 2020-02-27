import 'package:flutter/material.dart';
import 'package:devtobe/widget/drawer.dart';

class FileList extends StatelessWidget {
  static const String routeName = '/file_list';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("fileList"),
        ),
        drawer: AppDrawer(),
        body: Center(child: Text("fileList")));
  }
}
