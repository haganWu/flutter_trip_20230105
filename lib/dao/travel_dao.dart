import 'package:flutter_trip/model/travel_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

var params = {
  "districtId": -1,
  "groupChannelCode": "RX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {'cid': "09031014111431397988"},
  "contentType": "json"
};
class TravelDao {
  static Future<TravelItemModel> fetch(String url,String groupChannelCode, int pageIndex, int pageSize) async {
    var parseUri = Uri.parse(url);
    Map paramsMap = params["pagePara"] as Map;
    paramsMap["pageIndex"] = pageIndex;
    paramsMap["pageSize"] = pageSize;
    params["groupChannelCode"] = groupChannelCode;
    final response = await http.post(parseUri,body: jsonEncode(params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); // 防止中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}
