
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:transparent_image/transparent_image.dart';

import '../util/common_utils.dart';
import '../util/navigator_util.dart';
import '../widget/loading_container.dart';
import '../widget/webview.dart';

class TravelTabPage extends StatefulWidget {

 final String travelUrl;
 final String channelCode;

  const TravelTabPage({Key? key,required this.channelCode, required this.travelUrl}) : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> with AutomaticKeepAliveClientMixin{

  final String url = "https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5";
  final int pageSize = 10;
  int pageIndex = 1;
  bool _loading = true;
  late TravelItemModel travelModel;
  List<TravelItem> travelItemList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: MediaQuery.removePadding(
              removeTop: true, context: context, child: _gridView()),
        ),
      ));
  }
  _gridView() {
    //0.62.x及以上用法
    return MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      itemCount: travelItemList?.length??0,
      itemBuilder: (BuildContext context, int index) => _TravelItem(
        index: index,
        item: travelItemList[index],
      ),
    );
  }
  void _loadData({loadMore = false}) {
    if(loadMore){
      pageIndex++;
    }else{
      pageIndex = 1;
    }
    TravelDao.fetch(widget.travelUrl, widget.channelCode, pageIndex, pageSize).then((TravelItemModel model){
      print("TravelDao.fetch --> "+jsonEncode(model));
      _loading = false;
      List<TravelItem> items = _filterItems(model!.resultList);
      setState((){
        if(travelItemList != null) {
          travelItemList?.addAll(items);
        }else{
          travelItemList = items;
        }
        travelModel = model;
      });
    }).catchError((e){
      _loading = false;
      print(e);
    });
  }

  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if(resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    for (var item in resultList) {
      if(item.article != null) {
        filterItems.add(item);
      }
    }
    return filterItems;
  }
  Future<void> _handleRefresh() async {
    _loadData();
  }

  // 缓存数据，切换tab页面是不重新刷新
  @override
  bool get wantKeepAlive => true;
}

class _TravelItem extends StatelessWidget {
  final TravelItem item;
  final int? index;

  const _TravelItem({Key? key, this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article!.urls.length > 0) {
          HiWebView webViewPage = HiWebView(
              url:item.article!.urls[0].h5Url!,title: "详情");
          NavigatorUtil.push(context, webViewPage);

        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(context),
              Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  item.article!.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          //设置最小初始高度，防止动态图片高度时的抖动
          constraints: BoxConstraints(
            minHeight: size.width / 2 - 10,
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item.article!.images[0].dynamicUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  const Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 12,
                      )),
                  // 防止文本超出
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _poiName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  String _poiName() {
    return item.article!.pois == null || item.article!.pois?.length == 0
        ? '未知'
        : item.article!.pois?[0]?.poiName ?? '未知';
  }

  _infoText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        // 两端分布
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article!.author?.coverImage?.dynamicUrl ?? "",
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article!.author?.nickName ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  item.article!.likeCount.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}