import 'package:flutter/material.dart';

class generalLogoSpace extends StatelessWidget {
  final Widget child;

  generalLogoSpace({required this.child});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/header.png',
            width: 150,
          ),
          child?? SizedBox(),
        ],
      ),
    );
  }
}
