import 'package:flutter/material.dart';

import '../pages/upload_page.dart';
import '../pages/user_page.dart';
import '../pages/list_gambar.dart';
import '../pages/pembayaran.dart';
import '../theme.dart';


class MainPages extends StatefulWidget {
  const MainPages({Key? key}) : super(key: key);

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProductForm(),
    ProfilePage(),
    ProductList()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POVSHOT'),
        backgroundColor: blackColor,
      ),
      drawer: Drawer(
        width: 150,
        child: Container(
          color: Colors.black, // Background color of the drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 100),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white, // Color of the icon
                ),
                title: Text(
                  'User',
                  style: TextStyle(
                    color: Colors.white, // Color of the text
                  ),
                ),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.cloud_upload,
                  color: Colors.white, // Color of the icon
                ),
                title: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white, // Color of the text
                  ),
                ),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.payment,
                  color: Colors.white, // Color of the icon
                ),
                title: Text(
                  'Payment',
                  style: TextStyle(
                    color: Colors.white, // Color of the text
                  ),
                ),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                  color: Colors.white, // Color of the icon
                ),
                title: Text(
                  'List Gambar',
                  style: TextStyle(
                    color: Colors.white, // Color of the text
                  ),
                ),
                selected: _selectedIndex == 3,
                onTap: () {
                  _onItemTapped(3);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
