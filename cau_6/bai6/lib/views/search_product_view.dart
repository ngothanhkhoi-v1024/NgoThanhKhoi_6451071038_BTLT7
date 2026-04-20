import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/api_service.dart';

class SearchProductView extends StatefulWidget {
  @override
  _SearchProductViewState createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _products = [];
  bool _isLoading = false;

  void _onSearch(String value) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _apiService.searchProducts(value);
      setState(() {
        _products = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search API - 6451071038')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm sản phẩm',
                hintText: 'Nhập tên sản phẩm...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearch, // Gọi API mỗi khi nhập từ khóa
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: _products.isEmpty
                ? Center(child: Text("Không tìm thấy sản phẩm nào"))
                : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text(_products[index].name),
                  subtitle: Text("ID: ${_products[index].id}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}