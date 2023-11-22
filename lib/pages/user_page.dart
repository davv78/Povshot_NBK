import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../network/api/url_api.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> users = [];

   SharedPreferences? _prefs;
  bool _isLoggedIn = false;

  Future<void> checkLoginStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = _prefs!.getBool('isLoggedIn') ?? false;

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse(BASEURL.apiHome));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      users = responseData.map((data) => Map<String, dynamic>.from(data)).toList();

      setState(() {});
    } else {
      print('Failed to fetch users: ${response.statusCode}');
    }
  }

  Future<void> deleteUser(String name) async {
    final response = await http.post(
      Uri.parse(BASEURL.apiDelete),
      body: {
        'action': 'delete',
        'name': name,
      },
    );

    if (response.statusCode == 200) {
      print('User deleted successfully');
      fetchUsers();
    } else {
      print('Failed to delete user: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
    checkLoginStatus();
  }
  

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: whiteColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: _isLoggedIn ? _buildUserTable() : _buildLoginPrompt(),
          ),
        ),
      ),
    ),
  );
}

Widget _buildUserTable() {
  return users.isEmpty
      ? Center(
          child: Text(
            'Tidak ada data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      : DataTable(
          columnSpacing: 20,
          horizontalMargin: 10,
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Telpon')),
            DataColumn(label: Text('Actions')),
          ],
          rows: users.map((user) {
            return DataRow(cells: [
              DataCell(Text(user['name'])),
              DataCell(Text(user['email'])),
              DataCell(Text(user['telpon'])),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Are you sure you want to delete this user?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteUser(user['name']);
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )),
            ]);
          }).toList(),
        );
}

Widget _buildLoginPrompt() {
  return Center(
    child: Text(
      'Please log in to view users',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
}