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
      "flutter": HighlightedWord(
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
      "Open-source": HighlightedWord(
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
      "iOS": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (contextb) {
                return AlertDialog(
                  title: Text("iOS"),
                  content: Text(
                      "iOS is a mobile operating system created and developed by Apple Inc. exclusively for its hardware."),
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
      "Fuchsia": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (contextb) {
                return AlertDialog(
                  title: Text("Fuchsia"),
                  content: Text(
                      "Fuchsia is a capability-based operating system currently being developed by Google."),
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
      "Google": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (contextb) {
                return AlertDialog(
                  title: Text("Google"),
                  content: Text(
                      "Google LLC is an American multinational technology company that specializes in Internet-related services and products, which include online advertising technologies, search engine, cloud computing, software, and hardware. It is considered one of the Big Four technology companies, alongside Amazon, Apple and Facebook."),
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
    HighlightMap highlightMap = HighlightMap(words);
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Highlight Example"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              TextHighlight(
                text: text,
                words: highlightMap.getMap,
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
