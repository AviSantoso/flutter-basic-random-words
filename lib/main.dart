import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:tutorial2/saved_word_pairs.dart';
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

class RandomWordsApp extends StatefulWidget {
  @override
  _RandomWordsAppState createState() => _RandomWordsAppState();
}

class _RandomWordsAppState extends State<RandomWordsApp> {
  var _showSavedButton;
  var _savedWordPairs = new SavedWordPairs(savedWords: new Set<WordPair>());

  void _showSavedItems() {
    final Iterable<ListTile> _tiles = _savedWordPairs.savedWords.map((WordPair pair) => ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 18.0),
          ),
        ));

    final listRoute = MaterialPageRoute(builder: (BuildContext context) {
      final List<Widget> divided = ListTile.divideTiles(context: context, tiles: _tiles).toList();

      return Scaffold(
          appBar: AppBar(
            title: Text("Saved Passwords"),
          ),
          body: ListView(
            children: divided,
          ));
    });
    Navigator.of(context).push(listRoute);
  }

  @override
  void initState() {
    super.initState();
    _showSavedButton = new IconButton(
      icon: Icon(Icons.list),
      onPressed: () {
        _showSavedItems();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Random Words Generator'),
          backgroundColor: Colors.red[700],
          actions: [_showSavedButton],
        ),
        body: RandomWords(_savedWordPairs));
  }
}
