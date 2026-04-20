import 'package:flutter/material.dart';
import '../views/update_user_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UpdateUserScreen(),
    );
  }
}