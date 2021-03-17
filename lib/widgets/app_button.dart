import 'package:flutter/material.dart';
import 'package:mobile_technologies_task/res/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;
  final BoxDecoration decoration;
  final TextStyle style;
  final Function onTap;
  final Widget child;
  final BorderRadiusGeometry border;
  final IconData iconData;

  AppButton(
      {this.text,
      this.color = AppColors.PrimaryColor,
      this.textColor = Colors.white,
      this.onTap,
      this.style,
      this.fontSize = 15,
      this.fontWeight = FontWeight.normal,
      this.textDecoration,
      this.border,
      this.child,
      this.decoration,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: decoration != null
            ? decoration
            : BoxDecoration(
                color: color,
                borderRadius:
                    border != null ? border : BorderRadius.circular(10),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) Icon(iconData, size: 24, color: textColor),
            child != null
                ? child
                : Text(
                    text,
                    style: style != null
                        ? style
                        : TextStyle(
                            decoration: textDecoration,
                            color: textColor,
                            fontSize: fontSize,
                            fontWeight: fontWeight),
                  ),
          ],
        ),
      ),
    );
  }
}
