import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';

customDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Coming Soon!'),
        content: const Text('This feature is coming soon!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigation.back();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
