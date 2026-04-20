import 'package:flutter/material.dart';
import '../views/news_list_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsListView(),
    );
  }
}