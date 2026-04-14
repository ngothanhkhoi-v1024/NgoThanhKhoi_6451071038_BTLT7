import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm - MSSV: 6451071038"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Product>(
        future: ApiService.fetchSingleProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          else if (snapshot.hasData) {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tên: ${product.title}",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Giá: \$${product.price}",
                    style: const TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Mô tả sản phẩm:",
                    style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text("Không có dữ liệu"));
        },
      ),
    );
  }
}