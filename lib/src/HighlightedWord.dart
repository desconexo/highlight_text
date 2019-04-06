import 'package:flutter/material.dart';

class HighlightedWord {
  final TextStyle textStyle;
  final VoidCallback onTap;

  HighlightedWord({
    @required this.onTap,
    this.textStyle = const TextStyle(
      color: Colors.red,
    ),
  });
}
