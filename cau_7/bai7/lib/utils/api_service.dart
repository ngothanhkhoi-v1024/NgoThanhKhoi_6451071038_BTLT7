import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class ApiService {
  final String baseUrl = "https://661899a79a41b1b3df5bc91b.mockapi.io/api/news";

  Future<List<NewsModel>> fetchNews() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Không thể tải tin tức');
    }
  }
}