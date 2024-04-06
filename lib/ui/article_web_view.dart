import 'package:flutter/material.dart';
import 'package:news_app/widget/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;
  const ArticleWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(url));

    return CustomScaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
