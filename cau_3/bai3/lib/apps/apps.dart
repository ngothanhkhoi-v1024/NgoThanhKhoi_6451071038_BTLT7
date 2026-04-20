import 'package:flutter/material.dart';
import '../views/create_post_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreatePostView(),
    );
  }
}