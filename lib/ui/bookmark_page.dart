import 'package:flutter/material.dart';
import 'package:news_app/data/result_state.dart';
import 'package:news_app/provider/database_provider.dart';
import 'package:news_app/widget/card_article.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  static const routeName = '/bookmark';
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (_, provider, __) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.bookmarks.length,
              itemBuilder: (context, index) {
                return CardArticle(article: provider.bookmarks[index]);
              },
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
