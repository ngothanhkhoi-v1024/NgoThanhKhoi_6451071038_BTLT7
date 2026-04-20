import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../utils/api_service.dart';

class CreatePostView extends StatefulWidget {
  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final ApiService _apiService = ApiService();
  String _serverResponse = "";

  void _handlePost() async {
    final post = PostModel(
      title: _titleController.text,
      body: _bodyController.text,
    );

    final response = await _apiService.createPost(post);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post created successfully')),
      );
      setState(() {
        _serverResponse = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post - 6451071038')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Nhập tiêu đề'),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(hintText: 'Nhập nội dung bài viết'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handlePost,
              child: Text('Gửi lên server'),
            ),
            SizedBox(height: 20),
            Text("In response từ server:"),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Text(_serverResponse),
            )
          ],
        ),
      ),
    );
  }
}