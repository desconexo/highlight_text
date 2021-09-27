library highlight_text;

import 'package:flutter/material.dart';

/// It stores the layout data about a word
class HighlightedWord {
  final TextStyle textStyle;
  final VoidCallback onTap;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  HighlightedWord({
    required this.onTap,
    required this.textStyle,
    this.decoration,
    this.padding,
  });
}

/// TextHighlight will provide you a easy way to display highlighted words on your app
class TextHighlight extends StatelessWidget {
  final String text;
  final Map<String, HighlightedWord> words;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final bool matchCase;

  final Map<String, String> originalWords = <String, String>{};

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
    this.matchCase = false,
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
    String boundText = text;
    for (String word in words.keys) {
      if (matchCase) {
        boundText = boundText.replaceAll(
            word, '<highlight>${words.keys.toList().indexOf(word)}<highlight>');
      } else {
        int strIndex = boundText.toLowerCase().indexOf(word.toLowerCase());
        if (strIndex >= 0) {
          originalWords.addAll(
              {word: boundText.substring(strIndex, strIndex + word.length)});
          boundText = boundText.replaceRange(strIndex, strIndex + word.length,
              '<highlight>${words.keys.toList().indexOf(word)}<highlight>');
        }
      }
    }

    List<String> splitTexts = boundText.split("<highlight>");
    splitTexts.removeWhere((s) => s.isEmpty);

    return splitTexts;
  }

  TextSpan _buildSpan(List<String> boundWords) {
    if (boundWords.isEmpty) return TextSpan();

    String nextToDisplay = boundWords.first;
    boundWords.removeAt(0);

    int? index = int.tryParse(nextToDisplay);

    if (index != null) {
      String currentWord = words.keys.toList()[index];
      String showWord = matchCase ? originalWords[currentWord]! : currentWord;
      return TextSpan(
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: words[currentWord]!.onTap,
              child: Container(
                padding: words[currentWord]!.padding,
                decoration: words[currentWord]!.decoration,
                child: Text(
                  showWord,
                  style: words[currentWord]!.textStyle,
                ),
              ),
            ),
          ),
          _buildSpan(boundWords),
        ],
      );
    }

    return TextSpan(
      text: nextToDisplay,
      style: textStyle,
      children: [
        _buildSpan(boundWords),
      ],
    );
  }
}
