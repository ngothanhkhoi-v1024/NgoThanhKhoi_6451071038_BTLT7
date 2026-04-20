import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/api_service.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final ApiService _apiService = ApiService();
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    try {
      final tasks = await _apiService.fetchTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể kết nối API')),
      );
    }
  }

  void _handleDelete(String id, int index) async {
    // 1. Gọi http.delete()
    final success = await _apiService.deleteTask(id);

    if (success) {
      // 2. Xóa item khỏi UI bằng setState
      setState(() {
        _tasks.removeAt(index);
      });
      // 3. Hiển thị Snackbar thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item biến mất khỏi danh sách - Xóa thành công!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xóa thất bại!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý task - 6451071038'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
          ? Center(child: Text("Danh sách trống"))
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final item = _tasks[index];
          // Sử dụng IconButton như gợi ý của đề bài
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(item.title),
            subtitle: Text("ID: ${item.id}"),
            trailing: IconButton(
              icon: Icon(Icons.delete_sweep, color: Colors.red),
              onPressed: () => _handleDelete(item.id, index),
            ),
          );
        },
      ),
    );
  }
}