import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  final String baseUrl = "https://661899a79a41b1b3df5bc91b.mockapi.io/api/products";

  Future<List<ProductModel>> searchProducts(String keyword) async {
    // Gọi API với query param ?name=keyword (MockAPI hỗ trợ filter theo key)
    final response = await http.get(Uri.parse('$baseUrl?name=$keyword'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Lỗi khi tìm kiếm');
    }
  }
}