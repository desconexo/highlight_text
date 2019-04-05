## Example

You can see the complete example in the [GitHub Repository](https://github.com/desconexo/highlight_text/tree/master/example).

Import the highlight library
``` dart
import 'package:highlight_text/highlight_text.dart';
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