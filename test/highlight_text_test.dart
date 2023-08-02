import 'package:flutter_test/flutter_test.dart';
import '../lib/src/text_element.dart';
import '../lib/src/highlighted_word.dart';
import '../lib/src/binding.dart';
import '../lib/src/sort.dart';

void main() {
  test('firstOccurance', () {
    expect(
      firstOccurance(['apple', 'an'], 'apple mango orange pineapple'),
      [
        MatchedElement(matchedIndex: 0, originalText: 'apple'),
        UnmatchedElement(' m'),
        MatchedElement(matchedIndex: 1, originalText: 'an'),
        UnmatchedElement('go orange pineapple'),
      ],
    );
  });

  test('lastOccurance', () {
    expect(
      lastOccurance(['apple', 'an'], 'apple mango orange pineapple'),
      [
        UnmatchedElement('apple mango or'),
        MatchedElement(matchedIndex: 1, originalText: 'an'),
        UnmatchedElement('ge pine'),
        MatchedElement(matchedIndex: 0, originalText: 'apple'),
      ],
    );
  });

  test('allOccurance', () {
    expect(
      allOccurance(['apple', 'an'], 'apple mango orange pineapple'),
      [
        MatchedElement(matchedIndex: 0, originalText: 'apple'),
        UnmatchedElement(' m'),
        MatchedElement(matchedIndex: 1, originalText: 'an'),
        UnmatchedElement('go or'),
        MatchedElement(matchedIndex: 1, originalText: 'an'),
        UnmatchedElement('ge pine'),
        MatchedElement(matchedIndex: 0, originalText: 'apple'),
      ],
    );
  });

  test('sortWords', () {
    final sorted = sortWords({
      'apple': HighlightedWord(),
      'orange': HighlightedWord(),
      'pineapple': HighlightedWord(),
    }.entries.toList());
    expect(
      sorted.map((entry) => entry.key).toList(),
      ['pineapple', 'orange', 'apple'],
    );
  });
}
