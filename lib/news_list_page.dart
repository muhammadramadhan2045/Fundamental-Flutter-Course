import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/article.dart';
import 'package:news_app/detail_page.dart';

class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/article.json'),
        builder: (context, snapshot) {
          final List<Article> articles = parseArticles(snapshot.data ?? '');
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return _buildArticleItem(context, articles[index]);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    leading: Hero(
      tag: article.urlToImage ?? '',
      child: Image.network(
        article.urlToImage ?? '',
        width: 100,
        errorBuilder: (context, error, stackTrace) =>
            const Center(child: Icon(Icons.error)),
      ),
    ),
    title: Text(article.title ?? ''),
    subtitle: Text(article.author ?? ''),
    onTap: () => Navigator.pushNamed(
      context,
      DetailPage.routeName,
      arguments: article,
    ),
  );
}

List<Article> parseArticles(String json) {
  if (json.isEmpty) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Article.fromJson(json)).toList();
}
