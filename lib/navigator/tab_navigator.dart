import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

import '../pages/demo/demo_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _selectColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        // 禁止页面左右滑动切换
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
          DemoPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,//将label固定
        unselectedItemColor: _defaultColor,
        selectedItemColor:_selectColor ,
        items: [
          _bottomItem("首页", Icons.home),
          _bottomItem("搜索", Icons.search),
          _bottomItem("旅拍", Icons.camera_alt),
          _bottomItem("我的", Icons.account_circle),
          // _bottomItem("Demo", Icons.settings),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon){
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _selectColor),
        label: title);
  }
}
