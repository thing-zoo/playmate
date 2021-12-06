import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {Key? key,
      required this.title,
      required this.image,
      required this.fontSize,
      required this.iconSize,
      this.onPressed})
      : super(key: key);
  final String title;
  final String image;
  final double iconSize;
  final double fontSize;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            image,
            width: iconSize,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
