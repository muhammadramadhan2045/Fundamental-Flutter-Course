import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/article.dart';
import 'package:news_app/article_web_view.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/articel_detail';

  final Article article;
  const DetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              title: const Text("Detail Page"),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: article.urlToImage ?? '',
                  child: Image.network(
                    article.urlToImage ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article.description ?? ''),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Text(
                        article.title ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Text('Date: ${article.publishedAt ?? ''}'),
                      const Divider(
                        color: Colors.grey,
                      ),
                      //author
                      Text('Author: ${article.author ?? ''}'),
                      //content
                      Text(
                        article.content ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        child: const Text('Read more'),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          ArticleWebView.routeName,
                          arguments: article.url,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
