import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List (GET API) - MSSV: 6451071038"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
        future: ApiService.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }

          else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    title: Text(users[index].name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(users[index].email),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("Không có dữ liệu"));
        },
      ),
    );
  }
}