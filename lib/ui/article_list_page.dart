import 'package:flutter/material.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/data/result_state.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widget/card_article.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatelessWidget {
  static const routeName = '/article_list';
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
      ),
      body: Consumer<NewsProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (state.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: state.result.articles?.length ?? 0,
              itemBuilder: (context, index) {
                return CardArticle(
                  article: state.result.articles?[index] ?? [] as Articles,
                );
              },
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text('Error: ${state.message}'),
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
