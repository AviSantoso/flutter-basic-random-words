import 'package:flutter/material.dart';
import './random_words.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Words Generator',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RandomWordsApp(),
    );
  }
}

class RandomWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Random Words Generator'),
          backgroundColor: Colors.red[700],
        ),
        body: RandomWords());
  }
}
