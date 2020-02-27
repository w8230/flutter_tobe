import 'package:devtobe/front/home.dart';
import 'package:flutter/material.dart';
import 'package:devtobe/http/httpHandler.dart';
import 'package:devtobe/model/emp.dart';
import 'package:devtobe/route/routing.dart';

class LoginPage extends StatelessWidget {
  Employee data = new Employee();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _showDialog(String msg) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('경고'),
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

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onSaved: (String value) {
        this.data.email = value;
      },
      decoration: InputDecoration(
        hintText: '아이디를 입력하세요.',
        icon: new Icon(
          Icons.account_circle,
          size: 20,
          color: Colors.grey,
        ),
      ),
      validator: (value) => value.isEmpty ? '아이디를 입력하세요.' : null,
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      onSaved: (String value) {
        this.data.password = value;
      },
      decoration: InputDecoration(
        hintText: '비밀번호를 입력하세요.',
        icon: new Icon(
          Icons.remove_red_eye,
          size: 20,
          color: Colors.grey,
        ),
      ),
      validator: (value) => value.isEmpty ? '비밀번호를 입력하세요.' : null,
    );

    Widget logo() {
      return new Hero(
        tag: 'logo1',
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 25.0,
            child: Image.asset('assets/logo5.png'),
          ),
        ),
      );
    }

    final loginBtn = RaisedButton(
      color: Color.fromRGBO(33, 100, 176, 1),
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.blueAccent,
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.lock_open,
            size: 13,
            color: Colors.white,
          ),
          Text(
            '로그인',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ],
      ),
      onPressed: () {
        if (this._formKey.currentState.validate()) {
          _formKey.currentState.save();
          userLogin(data.email, data.password).then((result) {
            if (result == 0) {
              _showDialog('아이디나 비밀번호를 확안하세요.');
            } else {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => HomePage()));
            }
          });
        }
      },
    );

    Widget bottomText() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Copyright © 2014 TOBESYSTEM Corp. All Rights Reserved.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 11.0,
          ),
        ),
      );
    }

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.indigo,
          ),
      home: new Scaffold(
        body: new Center(
          child: new Form(
            key: this._formKey,
            child: new ListView(
              padding: EdgeInsets.only(top: 80.0, left: 24.0, right: 24.0),
              children: <Widget>[
                logo(),
                SizedBox(height: 50.0),
                email,
                SizedBox(height: 25.0),
                password,
                SizedBox(height: 50.0),
                loginBtn,
                SizedBox(height: 50.0),
                bottomText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
