import 'highlighted_word.dart';

// sort words by length,
// so that we process longer words first in binding
List<MapEntry<String, HighlightedWord>> sortWords(
    List<MapEntry<String, HighlightedWord>> words) {
  return words
    ..sort(
      (a, b) => b.key.length.compareTo(a.key.length),
    );
}
