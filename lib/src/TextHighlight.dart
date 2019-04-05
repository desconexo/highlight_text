import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:highlight_text/src/HighlightedWord.dart';

class TextHighlight extends StatefulWidget {
  final String text;
  final Map<String, HighlightedWord> words;
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
  _TextHighlightState createState() => _TextHighlightState();
}

class _TextHighlightState extends State<TextHighlight> {
  List<String> _textWords = List();
  bool firstWord = true;
  @override
  void initState() {
    super.initState();
    _textWords = widget.text.split(" ");
  }

  @override
  Widget build(BuildContext context) {
    String firstWord = _textWords[0];
    _textWords.remove(firstWord);
    return RichText(
      text: _setTextSpan(firstWord, _textWords),
      locale: widget.locale,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      softWrap: widget.softWrap,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      textScaleFactor: widget.textScaleFactor,
    );
  }

  TextSpan _setTextSpan(String p, List<String> words) {
    if (words.length != 0) {
      if (!firstWord) {
        String nextWord = words.first;
        words.remove(nextWord);
        if (widget.words.containsKey(p)) {
          return TextSpan(
            text: p + " ",
            children: <TextSpan>[
              _setTextSpan(nextWord, words),
            ],
            style: widget.words[p].textStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => widget.words[p].onTap,
          );
        } else {
          return TextSpan(
            text: p + " ",
            style: widget.textStyle,
            children: <TextSpan>[
              _setTextSpan(nextWord, words),
            ],
          );
        }
      } else {
        firstWord = false;
        return TextSpan(
          text: "",
          style: widget.textStyle,
          children: <TextSpan>[
            _setTextSpan(p, words),
          ],
        );
      }
    } else {
      return TextSpan(
        text: words.length > 0 ? p + " " : p,
        style: widget.textStyle,
      );
    }
  }
}
