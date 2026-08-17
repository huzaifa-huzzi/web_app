import 'package:flutter/material.dart';
import 'package:web_app/Resources/TextTheme.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Notification Screen',style: TTextTheme.h1Style(context),)
        ],
      ),
    );
  }
}
