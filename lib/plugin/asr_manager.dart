
import 'package:flutter/services.dart';

class AsrManager {
  // 初始化methodChannel 用于Dart与原生端的通信
  static const MethodChannel _channel = MethodChannel('asr_plugin');

   // 开始录音
  static Future<String> start({Map? params}) async {
    return await _channel.invokeMethod('start', params?? {});
  }
   // 停止录音
  static Future<String> stop() async {
    return await _channel.invokeMethod('stop');
  }
   // 取消录音
  static Future<String> cancel() async {
    return await _channel.invokeMethod('cancel');
  }
}