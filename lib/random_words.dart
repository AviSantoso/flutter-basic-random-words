import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  static const _wordsPerPage = 10;
  static const _wordsOnStartup = 50;

  final _randomWords = <WordPair>[];
  final _savedWords = Set<String>();
  final _scrollController = ScrollController();

  void _loadMore() {
    setState(() {
      _randomWords.addAll(generateWordPairs().take(_wordsPerPage));
    });
  }

  void _saveWord(String favString) {
    setState(() {
      _savedWords.add(favString);
    });
  }

  void _unsaveWord(String favString) {
    setState(() {
      _savedWords.remove(favString);
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

            final randomWord = _randomWords[index].asPascalCase;
            final isSaved = _savedWords.contains(randomWord);

            final tileContent = Row(
              children: [
                Flexible(child: Text((index + 1).toString())),
                VerticalDivider(),
                Expanded(
                  child: Text(randomWord),
                )
              ],
            );

            final favButton = isSaved
                ? IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red[700],
                    ),
                    onPressed: () => _unsaveWord(randomWord))
                : IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () => _saveWord(randomWord));

            return ListTile(title: tileContent, trailing: favButton);
          },
        ));
  }
}
