import 'package:flutter/material.dart';
import 'package:web_app/Resources/TextTheme.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Setting Screen',style: TTextTheme.h1Style(context),)
        ],
      ),
    );
  }
}
