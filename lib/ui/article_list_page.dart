import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/widget/card_article.dart';

class ArticleListPage extends StatefulWidget {
  static const routeName = '/article_list';
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<Article> article;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    article = ApiService().getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
      ),
      body: FutureBuilder<Article>(
          future: article,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return CardArticle(
                      article:
                          snapshot.data?.articles?[index] ?? [] as Articles,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Material(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              } else {
                return const Center(
                  child: Text('No Data'),
                );
              }
            }
          }),
    );
  }
}
