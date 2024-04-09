import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/ui/article_web_view.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Articles article;
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? 'Article Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Hero(
                tag: article.urlToImage ?? 'https://via.placeholder.com/150',
                child: Image.network(
                    article.urlToImage ?? 'https://via.placeholder.com/150'),
              ),
              const SizedBox(height: 10),
              Text(
                article.title ?? 'Title',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                article.description ?? 'Description',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Read More'),
                onPressed: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   ArticleWebView.routeName,
                  //   arguments: article.url ?? 'https://newsapi.org/',
                  // );

                  Navigation.intentWithData(ArticleWebView.routeName,
                      article.url ?? 'https://newsapi.org/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
