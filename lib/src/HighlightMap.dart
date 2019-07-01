import 'dart:collection';
import 'package:highlight_text/src/HighlightedWord.dart';

class HighlightMap {
  LinkedHashMap<String, HighlightedWord> _hashMap = LinkedHashMap(
    equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
    hashCode: (a) => a.toLowerCase().hashCode,
  );

  HighlightMap(Map<String, HighlightedWord> myMap) {
    myMap.forEach((k, v) {
      _hashMap[k] = v;
    });
  }

  get getMap => _hashMap;
}