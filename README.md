# Highlight Text Plugin

A flutter package to highlight words from a text.

## Usage

To use this package, add `highlight_text` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Getting Started

With this package you can highlight words and create specific actions for each highlighted word, you can customize the style of each word separately or create a unique style for all of them, you can also customize the style of the rest of the text.

## Example

Import the highlight library
``` dart
import 'package:highlight_text/highlight_text.dart';
```

You should use the `HighlightedWord` class to specify the dictionary words in a Map object
``` dart
Map<String, HighlightedWord> words = {
    "Flutter": HighlightedWord(
        onTap: () {
            print("Flutter");
        },
        textStyle: textStyle,
    ),
    "open-source": HighlightedWord(
        onTap: () {
            print("open-source");
        },
        textStyle: textStyle,
    ),
    "Android": HighlightedWord(
        onTap: () {
            print("Android");
        },
        textStyle: textStyle,
    ),
};
```

Now you can call the `TextHighlight` widget
``` dart
TextHighlight(
    text: text, // You need to pass the string you want the highlights
    words: words, // Your dictionary words
    textStyle: TextStyle( // You can set the general style, like a Text()
        fontSize: 20.0,
        color: Colors.black,
    ),
    textAlign: TextAlign.justify, // You can use any attribute of the RichText widget
),
```

## 0.7.0 Update
Now you can choose to differentiate words with upper and lower case.
To differentiate words by uppercase or lowercase letters just use as in the previous examples. To not differentiate words (text == TeXt) use the new HighlightMap class by passing its word library as a parameter.

``` dart
HighlightMap highlightMap = HighlightMap(words);
```

And then you pass the `highlightMap.getMap` as the `words` parameter in the `TextHighlight` widget

``` dart
TextHighlight(
    text: text,
    words: highlightMap.getMap,
),
```