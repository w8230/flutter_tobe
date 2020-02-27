import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:devtobe/widget/painter/path_histories.dart';
import 'package:devtobe/widget/painter/widget/drawing_painter.dart';
import 'package:devtobe/widget/painter/utility/bus_state.dart';
import 'package:devtobe/widget/painter/utility/common.dart';
import 'package:devtobe/widget/painter/utility/event.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:photo_view/photo_view.dart';
import 'package:easy_dialogs/easy_dialogs.dart';

class BoardWdiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardWdigetState();
}

class _BoardWdigetState extends BusState<BoardWdiget> {
  PhotoViewController photoViewController;
  double _strokeWidth = 3.0;
  Color _color = Colors.black;
  bool _isEraserMode = false;
  PointMode _pointMode = PointMode.polygon;
  ImageProvider _backgroundImage;
  final _histories = PathHistories();
  final _boardGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _setupEvent();
  }
  String _ringTone = "None";

  final List<String> _ringTones = [
    'None',
    'Callisto',
    'Ganymede',
    'Luna',
    'Oberon',
    'Phobos',
    'Dione',
    'Jungle Gym',
    'Ukulele',
    'Snowflakes',
  ];

  _openRingtoneDialog() {
    showDialog(
        context: context,
        builder: (context) => SingleChoiceConfirmationDialog<String>(
            title: Text('Phone ringtone'),
            initialValue: _ringTone,
            items: _ringTones, onSelected: _onSelected, onSubmitted: _onSubmitted));
  }

  void _onSelected(String value) {
    print('Selected $value');
    setState(() {
      _ringTone = value;
    });
  }

  void _onSubmitted(String value) {
    print('Submitted $value');
    setState(() {
      _ringTone = value;
    });
  }

  void Alert(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('알림'),
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget _build(BuildContext context) {
    return PhotoView(
      controller: photoViewController,
      imageProvider: _getBackgroundImage(),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 2,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      loadingChild: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


  @override
  Widget  build(BuildContext context) {
    return RepaintBoundary(
      key: _boardGlobalKey,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: _getBackgroundImage(),
          ),
        ),
        child: GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanStart: _onPanStart,
          onPanEnd: _onPanEnd,
          onDoubleTap: () {
            _openRingtoneDialog();
          },
//          onScaleUpdate: (ScaleUpdateDetails details){
//            Alert(context,'스케일 업데이트');
//          },
          onLongPress: () {
            Alert(context, '길게 누름');
          },

          onTap: () {
            Alert(context, '탭');
          },
          child: ClipRect(
            child: CustomPaint(
              size: Size.infinite,
              painter: DrawingPainter(histories: _histories),
            ),
          ),
        ),
      ),
    );
  }

  _setupEvent() {
    eventBusSubscription = eventBus.on<AppEvent>().listen((event) {
      if (event is ClearBoardEvent) {
        _clear();
      } else if (event is ChangeColorEvent) {
        _changeColor(event.color);
      } else if (event is ExportImageEvent) {
        _takeScreenshot();
      } else if (event is UndoEvent) {
        _undo();
      } else if (event is RedoEvent) {
        _redo();
      } else if (event is ChangeDrawModeEvent) {
        _changeDrawingMode();
      } else if (event is EraserEvent) {
        _toggleBlendMode();
      } else if (event is ShareEvent) {
        _share();
      } else if (event is ChangeBackgroundEvent) {
        _pickImage(0);
      } else if (event is CameraEvent) {
        _pickImage(1);
      } else if (event is FillEvent) {
        _changeBackgroundColor(event.color);
      }
    });
  }

  _onPanStart(DragStartDetails details) {
    setState(() {
      final renderBox = context.findRenderObject() as RenderBox;
      final point = renderBox.globalToLocal(details.globalPosition);

      _histories.startSession(_createPaint(), _pointMode);
      _histories.addPoint(point);
    });
  }

  _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      final renderBox = context.findRenderObject() as RenderBox;
      final point = renderBox.globalToLocal(details.globalPosition);
      _histories.addPoint(point);
    });
  }

  _onPanEnd(DragEndDetails details) {
    setState(() {
      _histories.finishSession();
    });
  }

  Paint _createPaint() {
    final color = _isEraserMode ? Colors.transparent : _color;
    final blendMode = _isEraserMode ? BlendMode.clear : BlendMode.srcOver;
    return Paint()
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..blendMode = blendMode
      ..color = color
      ..strokeWidth = _strokeWidth;
  }

  ImageProvider _getBackgroundImage() {
    if (_backgroundImage != null) {
      return _backgroundImage;
    }
    return AssetImage(
      pathOfImages('background.png'),
    );
  }

  _clear() {
    setState(() {
      _backgroundImage = null;
      if (_histories.paths.isEmpty) {
        return;
      }
      _histories.clear();
    });
  }

  _changeColor(Color color) {
    setState(() {
      _color = color.withOpacity(_color.opacity);
    });
  }

  _changeStrokeWidth(double strokeWidth) {
    setState(() {
      _strokeWidth = strokeWidth;
    });
  }

  _changeOpacity(double opacity) {
    setState(() {
      _color = _color.withOpacity(opacity);
    });
  }

  _undo() {
    setState(() {
      _histories.undo();
    });
  }

  _redo() {
    setState(() {
      _histories.redo();
    });
  }

  _changeDrawingMode() {
    setState(() {
      if (_pointMode == PointMode.polygon) {
        _pointMode = PointMode.lines;
      } else if (_pointMode == PointMode.lines) {
        _pointMode = PointMode.points;
      } else {
        _pointMode = PointMode.polygon;
      }
    });
  }

  _takeScreenshot() {
    if (_histories.paths.isEmpty) {
      return;
    }

    takeScreenShot(_boardGlobalKey);
  }

  _changeBackgroundColor(Color color) {
    setState(() {
      _histories.changeBackgroundColor(color);
    });
  }

  _toggleBlendMode() {
    _isEraserMode = !_isEraserMode;
  }

  Future _pickImage(int gb) async {
    if(gb == 0){
      var image = await ImagePicker.pickImage(source : ImageSource.gallery);

      if (image == null) {
        return;
      }

      setState(() {
        _backgroundImage = FileImage(image);
      });
    }else{
      var image = await ImagePicker.pickImage(source : ImageSource.camera);

      if (image == null) {
        return;
      }

      setState(() {
        _backgroundImage = FileImage(image);
      });
    }
  }

  _share() {
    Share.share('그림 편집본');
  }
}
