import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final Color? color;

  const CustomImage(
      {super.key, required this.image, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      width: width,
      height: height,
      color: color,
    );
  }
}
