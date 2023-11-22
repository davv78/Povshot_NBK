import 'package:flutter/material.dart';


class WidgetIlustration extends StatelessWidget {
  final Widget child;
  final String image;

  WidgetIlustration({
    required this.child,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 350,
        ),
        SizedBox(height: 270),
        if (child != null)
          child,
        SizedBox(height: 45,)
      ],
    );
  }
}
