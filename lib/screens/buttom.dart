import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';


class customerBottomTab extends StatefulWidget {
  @override
  _tabState createState() => _tabState();
}

class _tabState extends State<customerBottomTab> {
  int currentIndex = 0;
  List _pageList=[
    //Home(),
    //Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      // 设置底部应用栏的高度
      preferredSize: Size.fromHeight(60.0),
      child: BottomAppBar(
        color: Colors.blue, // 设置底部应用栏的颜色
        shape: CircularNotchedRectangle(), // 底部应用栏的形状
        elevation: 10, // 阴影
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // 处理点击“Home”按钮的操作
                /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );*/
                context.go('/catalog/cart');
                //context.pushReplacement('/catalog/cart');
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // 处理点击“Search”按钮的操作
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // 处理点击“Profile”按钮的操作
              },
            ),
          ],
        ),
      ),
    );
  }
}
