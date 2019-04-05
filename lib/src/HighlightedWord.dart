import 'package:flutter/material.dart';

class HighlightedWord {
  final String meaning;
  final TextStyle textStyle;
  final Function(BuildContext) onTap;

  HighlightedWord({
    @required this.meaning,
    @required this.onTap,
    this.textStyle = const TextStyle(
      color: Colors.red,
    ),
  });
}
