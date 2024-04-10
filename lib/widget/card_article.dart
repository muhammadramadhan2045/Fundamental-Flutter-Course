import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/provider/database_provider.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Articles article;
  const CardArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, provider, __) {
        return FutureBuilder(
            future: provider.isBookmarked(article.url ?? ''),
            builder: (context, snapshot) {
              var isBookmarked = snapshot.data ?? false;
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  leading: Hero(
                    tag:
                        article.urlToImage ?? 'https://via.placeholder.com/150',
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
                  trailing: isBookmarked
                      ? IconButton(
                          icon: const Icon(Icons.bookmark),
                          onPressed: () {
                            provider.removeBookmark(article.url ?? '');
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: () {
                            provider.addBookmark(Articles(
                              author: article.author,
                              title: article.title,
                              description: article.description,
                              url: article.url,
                              urlToImage: article.urlToImage,
                              publishedAt: article.publishedAt,
                            ));
                          },
                        ),
                  onTap: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   ArticleDetailPage.routeName,
                    //   arguments: article,
                    // );
                    Navigation.intentWithData(
                        ArticleDetailPage.routeName, article);
                  },
                ),
              );
            });
      },
    );
  }
}
