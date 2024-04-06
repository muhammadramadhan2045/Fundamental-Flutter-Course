import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Article List'),
          onPressed: () {
            Navigator.pushNamed(context, '/article_list');
          },
        ),
      ),
    );
  }
}
