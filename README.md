# Highlight Text Plugin

A flutter plugin to highlight words from a text.

## Usage

To use this plugin, add `highlight` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Getting Started

With this plugin you can highlight words and create specific actions for each highlighted word, you can customize the style of each word separately or create a unique style for all of them, you can also customize the style of the rest of the text.

## Example

Import the highlight library
``` dart
import 'package:highlight/highlight.dart';
```

You should use the `HighlightedWord` class to specify the dictionary words in a Map object
``` dart
Map<String, HighlightedWord> words = {
    "Flutter": HighlightedWord(
        meaning: "Flutter's engine, written primarily in C++, provides low-level rendering support using Google's Skia graphics library.",
        onTap: (context) {},
        textStyle: textStyle,
    ),
    "open-source": HighlightedWord(
        meaning: "Open-source software (OSS) is a type of computer software in which source code is released under a license in which the copyright holder grants users the rights to study, change, and distribute the software to anyone and for any purpose.",
        onTap: (context) {},
        textStyle: textStyle,
    ),
    "Android": HighlightedWord(
        meaning: "Android is a mobile operating system developed by Google.",
        onTap: (context) {},
        textStyle: textStyle,
    ),
};
```

Now you can call the widget `TextHighlight`
``` dart
TextHighlight(
    text: text, // You need to pass the string you want the highlights
    words: words, // Your dictionary words
    textStyle: TextStyle( // You can set the style, like a Text()
        fontSize: 20.0,
        color: Colors.black,
    ),
    textAlign: TextAlign.justify, // You can use any attribute of the RichText widget
),
```