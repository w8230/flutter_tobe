import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:devtobe/widget/drawer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(title: Text('이미지 편집'),),
          body: ImageAndCamera(),
        ));
  }
}

class ImageAndCamera extends StatefulWidget {
  @override ImageAndCameraState createState() => ImageAndCameraState();
}

class ImageAndCameraState extends State<ImageAndCamera> {
  File mPhoto;

  @override
  Widget build(BuildContext context) {
    Widget photo = (mPhoto != null) ? Image.file(mPhoto) : Text('이미지가 존재하지않습니다.');
    return Container(
      child: Column(children: <Widget>[
        // 버튼을 제외한 영역의 가운데 출력
        Expanded(
          child: Center(child: photo),
        ),
        Row(
          children: <Widget>[
            FloatingActionButton(
                heroTag: "btn-gallery",
                child: Icon(Icons.image),
                onPressed: () => onPhoto(ImageSource.gallery),
            ),
            FloatingActionButton(
              heroTag: "btn-camera",
              child: Icon(Icons.camera_alt),
              onPressed: () => onPhoto(ImageSource.camera),
            ),
            FloatingActionButton(
              heroTag: "btn-crop",
              child: Icon(Icons.crop),
              onPressed: () {
                if (mPhoto == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("사진을 첨부해주세요."),
                        );
                      });
                } else {

                }
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,),
      ], mainAxisAlignment: MainAxisAlignment.end,),);
  }

  void onPhoto(ImageSource source) async {
    File f = await ImagePicker.pickImage(source: source);
    setState(() => mPhoto = f);
  }
}
