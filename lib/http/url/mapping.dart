import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:devtobe/model/emp.dart';

Future<Employee> userLogin() async {
  final response = await http.get('http://192.168.0.8:8091/login');

  if (response.statusCode == 200) {
    final Employee emp = json.decode(utf8.decode(response.bodyBytes));
    return emp;
  }
  throw Exception('데이터 수신 실패!');
}