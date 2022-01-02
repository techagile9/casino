import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final Function() onPressed;
  final Color color;
  final TextStyle textStyle;

  const ButtonWidget(
      {Key? key,
      this.width = 200,
      this.height = 50,
      required this.title,
      required this.onPressed,
      this.color = Colors.purple,
      this.textStyle =
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        child: Text(title, style: textStyle),
      ),
    );
  }
}
