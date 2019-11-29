import 'dart:async';

import 'package:flutter/services.dart';

class FlutterOpenApp {
  static const MethodChannel _channel =
      const MethodChannel('flutter_open_app');

  static Future<String>  openUrl(String url) async {
    final String data = await _channel.invokeMethod('openUrl',{
      "openUrl":url,
    });
    return data;
  }
}
