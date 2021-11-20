import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.height = kToolbarHeight + 16,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Offers Galore",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color(0xFF1D262C)),
            ),
          ),
          CircleAvatar(
            child: ClipOval(
              child: Image.asset(
                'assets/me.jpg',
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
