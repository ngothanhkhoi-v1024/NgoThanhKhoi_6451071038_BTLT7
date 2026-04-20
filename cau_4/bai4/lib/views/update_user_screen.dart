import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/api_service.dart';
import '../widgets/custom_text_field.dart';

class UpdateUserScreen extends StatefulWidget {
  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  UserModel? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      final user = await _apiService.getUser("1");
      setState(() {
        _currentUser = user;
        _nameController.text = user.name;
        _emailController.text = user.email;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _handleUpdate() async {
    if (_formKey.currentState!.validate()) {
      _currentUser!.name = _nameController.text;
      _currentUser!.email = _emailController.text;

      final success = await _apiService.updateUser(_currentUser!.id, _currentUser!);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cập nhật thành công!')),
        );
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hồ sơ cá nhân - 6451071038')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(controller: _nameController, label: 'Tên'),
              CustomTextField(controller: _emailController, label: 'Email'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleUpdate,
                child: Text('Cập nhật'),
              ),
              if (_currentUser != null) ...[
                SizedBox(height: 20),
                Text("Dữ liệu hiện tại: ${_currentUser!.name} - ${_currentUser!.email}"),
              ]
            ],
          ),
        ),
      ),
    );
  }
}