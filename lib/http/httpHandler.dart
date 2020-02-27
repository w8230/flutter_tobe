import 'dart:async';
import 'dart:convert';
import 'package:devtobe/model/emp.dart';
import 'package:devtobe/model/menu.dart';
import 'package:http/http.dart' as http;

Future<int> userLogin(String idx, String pwd) async {
  final url = 'http://192.168.1.147:8091/userLogin?email=$idx&password=$pwd';
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return int.parse(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('데이터 요청에 실패하였습니다.');
  }
}

Future<Employee> getUserData(String idx) async {
  final url = 'http://192.168.1.147:8091/getUserData?email=$idx';
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes));
      return Employee.fromJson(data);
  } else {
    throw Exception('데이터 요청에 실패하였습니다.');
  }
}

Future<List<Menu>> getMenu() async {
  final url = 'http://192.168.1.147:8091/getMenu';
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes));
    List<Menu> map = [];
    for(var maps in data) {
      map.add(Menu(
        menu_id: maps['menu_id'],
        menu_name: maps['menu_name'],
        step: maps['step']
      ));
    }
    return map;
  } else {
    throw Exception('데이터 요청에 실패하였습니다.');
  }
}