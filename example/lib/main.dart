import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

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
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Flutter"),
                  content: Text(
                      "Flutter's engine, written primarily in C++, provides low-level rendering support using Google's Skia graphics library."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
      ),
      "open-source": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("open-source"),
                  content: Text(
                      "Open-source software (OSS) is a type of computer software in which source code is released under a license in which the copyright holder grants users the rights to study, change, and distribute the software to anyone and for any purpose."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
      ),
      "Android": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (contextb) {
                return AlertDialog(
                  title: Text("Android"),
                  content: Text(
                      "Android is a mobile operating system developed by Google."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(contextb).pop();
                      },
                      child: Text("Ok"),
                    )
                  ],
                );
              });
        },
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
