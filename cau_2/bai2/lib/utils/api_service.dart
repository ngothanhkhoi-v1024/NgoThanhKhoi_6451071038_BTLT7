import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {

  static const String apiUrl = "https://69dda6e4410caa3d47b9b88a.mockapi.io/product/1";

  static Future<Product> fetchSingleProduct() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Lỗi khi tải dữ liệu từ API: ${response.statusCode}");
    }
  }
}