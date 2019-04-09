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
  bool isFirstWord = true;
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
    if (!isFirstWord) {
      String nextWord = "";
      if (words.length > 0) {
        nextWord = words.first;
        words.remove(nextWord);
      }
      String charLastRemoved = p[p.length - 1];
      String wordLastRemoved = p.substring(0, p.length - 1);
      bool lastRemoved = false;
      if (widget.words.containsKey(p) ||
          widget.words.containsKey(wordLastRemoved)) {
        if (widget.words.containsKey(wordLastRemoved) && wordLastRemoved.length + 1 == p.length) lastRemoved = true;
        return TextSpan(
          text: !lastRemoved ? p + " " : wordLastRemoved,
          children: <TextSpan>[
            lastRemoved
                ? TextSpan(
                    text: charLastRemoved + " ",
                    style: widget.textStyle,
                    children: <TextSpan>[
                      words.length > 0
                          ? _setTextSpan(nextWord, words)
                          : TextSpan(
                              text: words.length >= 0 ? p + " " : nextWord,
                              style: widget.textStyle,
                            ),
                    ],
                  )
                : words.length > 0
                    ? _setTextSpan(nextWord, words)
                    : words.length > 0
                        ? TextSpan(
                            text: p + " ",
                          )
                        : _singleHighlight(nextWord),
          ],
          style: widget.words[!lastRemoved ? p : wordLastRemoved].textStyle,
          recognizer: TapGestureRecognizer()
            ..onTap =
                () => widget.words[!lastRemoved ? p : wordLastRemoved].onTap(),
        );
      } else {
        return TextSpan(
          text: p + " ",
          style: widget.textStyle,
          children: <TextSpan>[
            words.length > 0
                ? _setTextSpan(nextWord, words)
                : TextSpan(
                    text: words.length >= 0 ? p + " " : nextWord,
                    style: widget.textStyle,
                  ),
          ],
        );
      }
    } else {
      isFirstWord = false;
      return TextSpan(
        text: "",
        style: widget.textStyle,
        children: <TextSpan>[
          _setTextSpan(p, words),
        ],
      );
    }
  }

  TextSpan _singleHighlight(String word) {
    String charLastRemoved = word[word.length - 1];
    String wordLastRemoved = word.substring(0, word.length - 1);
    bool lastRemoved = false;
    if (widget.words.containsValue(word) ||
        widget.words.containsKey(wordLastRemoved)) {
      if (widget.words.containsKey(wordLastRemoved) && wordLastRemoved.length +1 == word.length) lastRemoved = true;
      return TextSpan(
        text: !lastRemoved ? word + " " : wordLastRemoved,
        style: widget.words[!lastRemoved ? word : wordLastRemoved].textStyle,
        children: <TextSpan>[
          lastRemoved
              ? TextSpan(
                  text: charLastRemoved,
                  style: widget.textStyle,
                )
              : TextSpan(),
        ],
        recognizer: TapGestureRecognizer()
          ..onTap =
              () => widget.words[!lastRemoved ? word : wordLastRemoved].onTap(),
      );
    } else {
      return TextSpan(
        text: word,
        style: widget.textStyle,
      );
    }
  }
}
