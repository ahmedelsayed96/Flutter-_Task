import 'package:flutter/cupertino.dart';

class HeightBox extends StatelessWidget {
  double height;
  Widget child;

  HeightBox(this.height,{child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,child: child,
    );
  }
}

class WidthBox extends StatelessWidget {
  double width;
  Widget child;
  WidthBox(this.width,{child});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(width:width,child:child
    );
  }
}
