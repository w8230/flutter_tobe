import 'package:devtobe/front/emp/empList.dart';
import 'package:devtobe/front/file/fileList.dart';
import 'package:devtobe/front/home.dart';
import 'package:devtobe/front/painter/painter_main.dart';
import 'package:devtobe/front/user/login.dart';
import 'package:devtobe/http/httpHandler.dart';
import 'package:flutter/material.dart';
import 'package:devtobe/route/routing.dart';
import 'package:devtobe/model/emp.dart';


class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: '자재 관리',
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePage()));
              },
          ),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: '생산 관리',
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => Painter()));
            },
          ),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: '품질 관리',
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          Divider(),
          _createDrawerItem(icon: Icons.laptop, text: '관리자'),
          Divider(),
          _createDrawerItem(icon: Icons.settings, text: '설정'),
          ListTile(
            title: Text('v1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
  // 서버 이미지 가져와서
  // 이미지 드로잉 -> 저장
  TextStyle _textStyle(){
    return new TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontWeight: FontWeight.w700
    );
  }

  Widget _createHeader(){
    return new UserAccountsDrawerHeader(
      accountName: new Text('김재일' , style: _textStyle()),
      accountEmail: new Text("투비시스템 / 개발팀" , style: _textStyle()),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new ExactAssetImage('assets/nav-menu-header-bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://www.pngitem.com/pimgs/m/516-5167304_transparent-background-white-user-icon-png-png-download.png")),
    );
  }

  Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon,size: 15,),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text,style: TextStyle(fontSize: 13),),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}