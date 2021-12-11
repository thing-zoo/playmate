import 'package:flutter/material.dart';
import 'package:playmate/screens/category/category_screen.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {Key? key,
      required this.title,
      required this.image,
      required this.fontSize,
      required this.iconSize,
      required this.category_num})
      : super(key: key);
  final String title;
  final String image;
  final double iconSize;
  final double fontSize;
  final int category_num;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryScreen(
              category_num: category_num,
              category_name: title,
            ),
          ),
        );
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
