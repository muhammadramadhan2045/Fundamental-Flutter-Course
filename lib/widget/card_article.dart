import 'package:flutter/material.dart';
import 'package:news_app/common/style.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Articles article;
  const CardArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: article.urlToImage ?? 'https://via.placeholder.com/150',
          child: Image.network(
            article.urlToImage ?? 'https://via.placeholder.com/150',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          article.title ?? 'Title',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          article.author ?? 'author',
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            ArticleDetailPage.routeName,
            arguments: article,
          );
        },
      ),
    );
  }
}
