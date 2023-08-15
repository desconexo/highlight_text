import 'package:flutter/material.dart';
import 'package:highlight_text/src/binding.dart';
import 'package:highlight_text/src/sort.dart';
import 'highlighted_word.dart';
import 'text_element.dart';

/// Defines what occurrence you want to highlight
enum HighlightBinding {
  /// Highlights all occurrences of a word
  all,

  /// Highlights only the first occurrence
  first,

  /// Highlights only the last occurrence
  last,
}

/// TextHighlight will provide you a easy way to display highlighted words on your app
class TextHighlight extends StatelessWidget {
  /// The text you want to show
  final String text;

  /// Map with the word you need to highlight
  final Map<String, HighlightedWord> words;

  /// Split the highlighted word to fit in the same line as the text
  final bool splitOnLongWord;

  /// Change the alignment of the text inside span
  final PlaceholderAlignment spanAlignment;

  /// If it is true, it will highlight the exactly same match
  final bool matchCase;

  /// Change the occurrence of a highlight
  final HighlightBinding binding;

  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;

  TextHighlight({
    required this.text,
    required this.words,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.matchCase = false,
    this.binding = HighlightBinding.all,
    this.spanAlignment = PlaceholderAlignment.middle,
    this.splitOnLongWord = false,
  });

  @override
  Widget build(BuildContext context) {
    final sortedWords = sortWords(words.entries.toList());
    final boundWords = _bind(
      sortedWords.map((entry) => entry.key).toList(),
    );

    return Text.rich(
      _buildSpan(sortedWords.map((entry) => entry.value).toList(), boundWords),
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
    );
  }

  List<TextElement> _bind(List<String> words) {
    switch (binding) {
      case HighlightBinding.first:
        return firstOccurance(words, text, matchCase);
      case HighlightBinding.last:
        return lastOccurance(words, text, matchCase);
      case HighlightBinding.all:
      default:
        return allOccurance(words, text, matchCase);
    }
  }

  TextSpan _buildSpan(
    List<HighlightedWord> highlightedWords,
    List<TextElement> boundWords,
  ) {
    return TextSpan(
      children: boundWords
          .map<List<InlineSpan>>((element) {
            if (element is MatchedElement) {
              final index = element.matchedIndex;
              try {
                final highlightedWord = highlightedWords[index];
                String showWord = element.originalText;
                final List<String> splittedWords = [];
                if (splitOnLongWord && showWord.contains(" ")) {
                  for (String w in showWord.split(" ")) {
                    splittedWords.addAll([w, " "]);
                  }
                } else {
                  splittedWords.add(showWord);
                }
                return splittedWords.map((w) {
                  if (w == ' ') {
                    return TextSpan(
                      text: '',
                      style: textStyle,
                    );
                  }
                  return WidgetSpan(
                    alignment: spanAlignment,
                    child: InkWell(
                      onTap: highlightedWord.onTap,
                      child: Container(
                        padding: highlightedWord.padding,
                        decoration: highlightedWord.decoration,
                        child: Text(
                          w,
                          style: highlightedWord.textStyle ?? textStyle,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                  );
                }).toList();
              } catch (e) {}
            }
            return [
              TextSpan(
                text: (element as UnmatchedElement).text,
                style: textStyle,
              )
            ];
          })
          .expand((span) => span)
          .toList(),
    );
  }
}
