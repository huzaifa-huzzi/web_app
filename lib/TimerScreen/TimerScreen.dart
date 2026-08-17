import 'package:flutter/material.dart';
import 'package:web_app/Resources/TextTheme.dart';


class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('TimerScreen',style: TTextTheme.h1Style(context),)
        ],
      ),
    );
  }
}
