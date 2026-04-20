import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task_model.dart';

class ApiService {
  // Sử dụng MockAPI hoặc URL API của bạn
  final String baseUrl = "https://69dda6e4410caa3d47b9b88a.mockapi.io/api/tasks";

  Future<List<TaskModel>> fetchTasks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Lỗi khi tải danh sách');
    }
  }

  Future<bool> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }
}