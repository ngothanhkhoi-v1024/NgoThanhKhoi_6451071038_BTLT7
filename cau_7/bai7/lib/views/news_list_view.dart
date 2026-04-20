import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../utils/api_service.dart';

class NewsListView extends StatefulWidget {
  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  final ApiService _apiService = ApiService();
  List<NewsModel> _newsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<void> _handleRefresh() async {
    try {
      final data = await _apiService.fetchNews();
      setState(() {
        _newsList = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi cập nhật dữ liệu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin tức - 6451071038'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _newsList.isEmpty
            ? ListView(
          children: [Center(child: Text("Không có tin tức nào"))],
        )
            : ListView.builder(
          itemCount: _newsList.length,
          itemBuilder: (context, index) {
            final item = _newsList[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(item.content),
                leading: Icon(Icons.article),
              ),
            );
          },
        ),
      ),
    );
  }
}