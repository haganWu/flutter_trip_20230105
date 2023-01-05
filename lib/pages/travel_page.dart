import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_tab_dao.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_trip/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key? key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {

  late TabController _controller;
  List<TravelTab> tabs = [];
  late TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model){
      print("ddd" + jsonEncode(model));
      _controller = TabController(length: model.tabs!.length, vsync: this);
      setState((){
        tabs = model.tabs!;
        travelTabModel = model;
      });
    }).catchError((e){
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 18),
              child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.lightBlue,width: 3,),
                  insets: EdgeInsets.fromLTRB(6,0,2, 0)
                ),
                tabs: tabs.map<Tab>((TravelTab tab){
                  return Tab(text: tab.labelName);
                }).toList(),
              ),
            ),
            // 解决高度丢失，撑满剩余空间
            Flexible(
                child: TabBarView(
                  controller: _controller,
                  children: tabs.map((TravelTab tab){
                    return Expanded(child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                      ),
                      child:TravelTabPage(travelUrl:travelTabModel.url!,channelCode: tab.groupChannelCode!)
                    ));
                  }).toList()
            ))
          ],
        )
    );
  }
}
