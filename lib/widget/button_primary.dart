import 'package:flutter/material.dart';

import '../theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final void Function()? OnTap;
  ButtonPrimary
  ({required this.text, required this.OnTap});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: OnTap,
        child: Text(
          text,
          style: TextStyle(
            color: whiteColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
