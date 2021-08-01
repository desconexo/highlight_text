library highlight_text;

import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HighlightedWord {
  final TextStyle textStyle;
  final VoidCallback onTap;

  HighlightedWord({
    required this.onTap,
    required this.textStyle,
  });
}

class TextHighlight extends StatelessWidget {
  final String text;
  final LinkedHashMap<String, HighlightedWord> words;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final bool enableCaseSensitive;

  TextHighlight({
    required this.text,
    required this.words,
    this.textStyle = const TextStyle(
      fontSize: 25.0,
      color: Colors.black,
    ),
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.enableCaseSensitive = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> _textWords = _bind();

    return RichText(
      text: _buildSpan(_textWords),
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
    );
  }

  List<String> _bind() {
    String bindedText = text;
    for (String word in words.keys) {
      if (enableCaseSensitive) {
        bindedText = bindedText.replaceAll(
            word, '<highlight>${words.keys.toList().indexOf(word)}<highlight>');
      } else {
        int strIndex = bindedText.toLowerCase().indexOf(word.toLowerCase());
        if (strIndex > 0)
          bindedText = bindedText.replaceRange(strIndex, strIndex + word.length,
              '<highlight>${words.keys.toList().indexOf(word)}<highlight>');
      }
    }

    List<String> splitedTexts = bindedText.split("<highlight>");
    splitedTexts.removeWhere((s) => s.isEmpty);

    return splitedTexts;
  }

  TextSpan _buildSpan(List<String> bindedWords) {
    if (bindedWords.isEmpty) return TextSpan();

    String nextToDisplay = bindedWords.first;
    bindedWords.removeAt(0);

    int? index = int.tryParse(nextToDisplay);

    if (index != null) {
      String currentWord = words.keys.toList()[index];
      return TextSpan(
        text: currentWord,
        style: words[currentWord]!.textStyle,
        children: [
          _buildSpan(bindedWords),
        ],
        recognizer: TapGestureRecognizer()
          ..onTap = () => words[currentWord]!.onTap(),
      );
    }

    return TextSpan(
      text: nextToDisplay,
      style: textStyle,
      children: [
        _buildSpan(bindedWords),
      ],
    );
  }
}
