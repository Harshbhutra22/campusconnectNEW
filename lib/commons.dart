import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String content;
  Color? color;
  double? size;
  double? spacing, wordSpacing;
  List<Shadow>? shadowList;
  FontWeight? weight;
  TextOverflow? overflow;
  int? maxLines;

  MyText(this.content,
      {super.key,
      this.color,
      this.size,
      this.spacing,
      this.wordSpacing,
      this.shadowList,
      this.weight,
      this.overflow,
      this.maxLines}) {
    color ??= Colors.black;
    size ??= 16;
    spacing ??= 0;
    wordSpacing ??= 0;
    shadowList ??= [];
    weight ??= FontWeight.normal;
    overflow ??= TextOverflow.clip;
    maxLines ??= null;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
        letterSpacing: spacing,
        wordSpacing: wordSpacing,
        shadows: shadowList,
        fontWeight: weight,
        overflow: overflow,
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    required this.controller,
    required this.label,
    super.key,
    this.obscureText,
    this.hint,
    this.maxLength,
    this.maxLines,
    this.height,
  }) {
    obscureText ??= false;
    maxLines ??= 1;
  }
  TextEditingController controller;
  String label;
  String? hint;
  bool? obscureText = false;
  int? maxLength, maxLines, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height != null) ? height!.toDouble() : 70,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          maxLength: (maxLength != null) ? maxLength : null,
          maxLines: (maxLines != null) ? maxLines : null,
          controller: controller,
          style: const TextStyle(
              color: Colors.black, fontSize: 14, letterSpacing: 2),
          obscureText: obscureText!,

          // decoration
          decoration: InputDecoration(
            hintText: ' $hint',
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            label: MyText(
              label,
              size: 13,
              spacing: 2,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonFunctions {
  double maxSize(double a, double b) {
    return (a < b) ? b : a;
  }

  double minSize(double a, double b) {
    return (a > b) ? b : a;
  }
}
