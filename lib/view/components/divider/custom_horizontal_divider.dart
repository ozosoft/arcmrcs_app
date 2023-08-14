import 'package:flutter/material.dart';

class CustomHorizontalDivider extends StatelessWidget {

  const CustomHorizontalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}
