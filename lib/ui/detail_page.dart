import 'package:flutter/material.dart';
import 'package:simple_notification_app/utils/received_notification.dart';

class DetailPage extends StatelessWidget {
  static const String routeName = '/detail';
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReceivedNotification arg =
        ModalRoute.of(context)!.settings.arguments as ReceivedNotification;
    return Scaffold(
      appBar: AppBar(
        title: Text(arg.payload ?? 'No Payload'),
      ),
      body: Center(
        child: Text(
          'Payload: ${arg.payload ?? 'No Payload'}',
        ),
      ),
    );
  }
}
