import 'package:flutter/material.dart';
import 'package:web_app/Resources/TextTheme.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Dashboard Scree',style:  TTextTheme.h1Style(context),)
        ],
      ),
    );
  }
}
