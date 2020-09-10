import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:tutorial2/saved_word_pairs.dart';

class RandomWords extends StatefulWidget {
  SavedWordPairs _savedWordPairs;

  RandomWords(SavedWordPairs savedWordPairs) {
    _savedWordPairs = savedWordPairs;
  }

  @override
  _RandomWordsState createState() => _RandomWordsState(_savedWordPairs);
}

class _RandomWordsState extends State<RandomWords> {
  static const _wordsPerPage = 10;
  static const _wordsOnStartup = 50;

  final _randomWords = <WordPair>[];
  final _scrollController = ScrollController();

  SavedWordPairs _savedWordPairs;

  _RandomWordsState(SavedWordPairs savedWordPairs) {
    _savedWordPairs = savedWordPairs;
  }

  void _loadMore() {
    setState(() {
      _randomWords.addAll(generateWordPairs().take(_wordsPerPage));
    });
  }

  void _saveWord(WordPair pair) {
    setState(() {
      _savedWordPairs.savedWords.add(pair);
    });
  }

  void _unsaveWord(WordPair pair) {
    setState(() {
      _savedWordPairs.savedWords.remove(pair);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _randomWords.addAll(generateWordPairs().take(_wordsOnStartup));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          itemCount: _randomWords.length + 1,
          padding: const EdgeInsets.all(18.0),
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            if (index > _randomWords.length) {
              return null;
            }

            if (index == _randomWords.length) {
              return ListTile(
                title: FlatButton(
                  onPressed: _loadMore,
                  child: Text("Load $_wordsPerPage More"),
                ),
              );
            }

            final randomPair = _randomWords[index];
            final isSaved = _savedWordPairs.savedWords.contains(randomPair);

            final tileContent = Row(
              children: [
                Flexible(child: Text((index + 1).toString())),
                VerticalDivider(),
                Expanded(
                  child: Text(randomPair.asPascalCase),
                )
              ],
            );

            final favButton = isSaved
                ? IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red[700],
                    ),
                    onPressed: () => _unsaveWord(randomPair))
                : IconButton(icon: Icon(Icons.favorite_border), onPressed: () => _saveWord(randomPair));

            return ListTile(title: tileContent, trailing: favButton);
          },
        ));
  }
}
