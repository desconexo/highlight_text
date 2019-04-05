import 'package:flutter/material.dart';
import 'package:highlight/highlight_text.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String text =
      "Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android and iOS, as well as being the primary method of creating applications for Google Fuchsia.";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Colors.red,
      fontSize: 26.0,
    );
    Map<String, HighlightedWord> words = {
      "Flutter": HighlightedWord(
        meaning:
            "Flutter's engine, written primarily in C++, provides low-level rendering support using Google's Skia graphics library.",
        onTap: (context) {},
        textStyle: textStyle,
      ),
      "open-source": HighlightedWord(
        meaning:
            "Open-source software (OSS) is a type of computer software in which source code is released under a license in which the copyright holder grants users the rights to study, change, and distribute the software to anyone and for any purpose.",
        onTap: (context) {},
        textStyle: textStyle,
      ),
      "Android": HighlightedWord(
        meaning: "Android is a mobile operating system developed by Google.",
        onTap: (context) {},
        textStyle: textStyle,
      ),
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Highlight Example"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              "With this plugin you can highlight words and create specific actions for each highlighted word, you can customize the style of each word separately or create a unique style for all of them, you can also customize the style of the rest of the text.",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextHighlight(
              text: text,
              words: words,
              textStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
