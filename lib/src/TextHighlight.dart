import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:highlight_text/src/HighlightedWord.dart';

class TextHighlight extends StatelessWidget {
  final String text;
  final LinkedHashMap<String, HighlightedWord> words;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final Locale locale;
  final StrutStyle strutStyle;

  TextHighlight({
    @required this.text,
    @required this.words,
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
  });

  @override
  Widget build(BuildContext context) {
    List<String> _textWords = List();
    _textWords = text.split(" ");
    return RichText(
      text: buildSpan(_textWords),
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

  TextSpan buildSpan(List<String> words) {
    if (words.length > 0) {
      String currentWord = words[0];
      words.remove(currentWord);
      String charLastRemoved = currentWord[currentWord.length - 1];
      String wordLastRemoved = currentWord.substring(0, currentWord.length - 1);

      if (this.words.containsKey(wordLastRemoved)) {
        return TextSpan(
          text: wordLastRemoved,
          style: this.words[wordLastRemoved].textStyle,
          children: [
            TextSpan(
              text: charLastRemoved + " ",
              style: textStyle,
            ),
            buildSpan(words),
          ],
          recognizer: TapGestureRecognizer()
            ..onTap = () => this.words[wordLastRemoved].onTap(),
        );
      } else {
        return TextSpan(
          text: currentWord + " ",
          style: this.words.containsKey(currentWord)
              ? this.words[currentWord].textStyle
              : textStyle,
          children: [
            buildSpan(words),
          ],
          recognizer: this.words.containsKey(currentWord)
              ? (TapGestureRecognizer()
                ..onTap = () => this.words[currentWord].onTap())
              : null,
        );
      }
    } else {
      return TextSpan(text: "");
    }
  }
}
