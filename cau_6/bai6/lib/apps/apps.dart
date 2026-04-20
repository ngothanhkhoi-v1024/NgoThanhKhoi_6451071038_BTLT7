import 'package:flutter/material.dart';
import '../views/search_product_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchProductView(),
    );
  }
}