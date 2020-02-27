import 'package:flutter/material.dart';
import 'package:devtobe/widget/painter/widget/dialog_color_picker.dart';
import 'package:devtobe/widget/painter/utility/event.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuWidget extends StatefulWidget {
  MenuWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final colorAlert = ColorPickerAlert();
  final fillAlert = ColorPickerAlert();

  @override
  void initState() {
    super.initState();

    colorAlert.onSuccess = () {
      setState(() {});
      eventBus.fire(ChangeColorEvent(colorAlert.currentColor));
    };

    fillAlert.onSuccess = () {
      eventBus.fire(FillEvent(fillAlert.currentColor));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.history,
            ),
            onPressed: () {
              eventBus.fire(ClearBoardEvent());
            },
          ),
          IconButton(
            color: colorAlert.currentColor,
            icon: new Icon(
              Icons.color_lens,
            ),
            onPressed: () {
              colorAlert.show(context);
            },
          ),
          IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.format_color_fill
            ),
            onPressed: () {
              fillAlert.show(context);
            },
          ),
          IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.create,
            ),
            onPressed: () {
              eventBus.fire(ChangeDrawModeEvent());
            },
          ),
          IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.file_download,
            ),
            onPressed: () {
              eventBus.fire(ExportImageEvent());
            },
          ),
          IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              eventBus.fire(UndoEvent());
            },
          ),
          IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.arrow_forward,
            ),
            onPressed: () {
              eventBus.fire(RedoEvent());
            },
          ),
          IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.image,
            ),
            onPressed: () {
              eventBus.fire(ChangeBackgroundEvent());
            },
          ),
          IconButton(
            color: Colors.black,
            icon: new Icon(
              Icons.camera_alt,
            ),
            onPressed: () {
              eventBus.fire(CameraEvent());
            },
          ),
//          IconButton(
//            color: Colors.black,
//            icon: new Icon(
//              FontAwesomeIcons.shareAlt,
//            ),
//            onPressed: () {
//              eventBus.fire(ShareEvent());
//            },
//          ),
        ],
      ),
    );
  }
}
