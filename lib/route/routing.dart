import 'package:devtobe/front/home.dart';
import 'package:devtobe/front/user/login.dart';
import 'package:devtobe/front/emp/empList.dart';
import 'package:devtobe/front/file/fileList.dart';
import 'package:devtobe/front/painter/painter_main.dart';
import 'package:devtobe/test.dart';

final routes = {
  '/11': (context) => LoginPage(),
  '/index': (context) => HomePage(),
  '/emp_list' : (context) => EmpList(),
  '/file_list' : (context) => FileList(),
  '/'  : (context) => Painter(),
  '/12'     : (context) => DrawingTest(),
};

//class Routes {
//  static const String emp_list = EmpList.routeName;
//  static const String file_list = FileList.routeName;
//  static const String login = LoginPage.routeName;
//  static const String index = HomePage.routeName;
//}