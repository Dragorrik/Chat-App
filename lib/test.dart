import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final Color? borderColor;
  final String? title;
  final TextStyle? textStyle;
  final Function()? onTap;

  const PrimaryButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.color,
    this.title,
    this.onTap,
    this.textStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 30,
        width: width ?? 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 6),
            color: color ?? Colors.teal,
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
          child: Text(
            title ?? "Button",
            style: textStyle ?? TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
