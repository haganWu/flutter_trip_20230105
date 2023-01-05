import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemoDefaultListView extends StatefulWidget {
  const DemoDefaultListView({Key? key}) : super(key: key);

  @override
  _DemoDefaultListViewState createState() => _DemoDefaultListViewState();
}

const CITY_NAMES = [
  "郑州",
  "深圳",
  "北京",
  "上海",
  "广州",
  "西安",
  "重庆",
  "南京",
  "延安",
  "苏州",
  "杭州"
];

class _DemoDefaultListViewState extends State<DemoDefaultListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: _buildList(),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 16,top: 6,right: 16,bottom: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        //背景渐变
          gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
          //6像素圆角
          borderRadius: BorderRadius.circular(6.0),
          //阴影
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ]),
      child: Text(
        city,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
