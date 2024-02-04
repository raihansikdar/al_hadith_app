import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  TextComponent({
    super.key,
    required this.text,
    this.textAlign,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily,
    required this.height,
    this.maxLines,
    this.overflow,
  });
  final String text;
  TextAlign? textAlign;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  String? fontFamily;
  final double height;
  int? maxLines;
  TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}