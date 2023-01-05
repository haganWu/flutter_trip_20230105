import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_trip/navigator/tab_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F携程',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabNavigator(),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: '全面屏适配',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: Container(
  //       decoration: const BoxDecoration(color: Colors.white),
  //       // 通过SafeArea解决全面屏问题
  //       child: SafeArea(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text('顶部'),
  //             Text('底部')
  //           ],
  //         ),
  //       ),
  //
  //     ),
  //   );
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: '全面屏适配',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: HomePage(),
  //   );
  // }
}

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Future.delayed(const Duration(milliseconds: 3000),(){
      FlutterSplashScreen.hide();
    });

    final EdgeInsets edgeInsets = MediaQuery.of(context).padding;
    return Container(
      padding: EdgeInsets.fromLTRB(0, edgeInsets.top, 0, edgeInsets.bottom),
      decoration: const BoxDecoration(color: Colors.white),
      // 通过SafeArea解决全面屏问题
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('顶部'),
          Text('底部')
        ],
      ),
    );
  }

}