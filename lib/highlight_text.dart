library highlight_text;

import 'package:flutter/services.dart';


export 'src/HighlightedWord.dart';
export 'src/TextHighlight.dart';

class HighlightText {
  static const MethodChannel _channel =
      const MethodChannel('highlight_text');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}