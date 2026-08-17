import 'package:flutter/material.dart';
import 'package:web_app/Resources/TextTheme.dart';


class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Help Center Screen',style: TTextTheme.h1Style(context),)
        ],
      ),
    );
  }
}
