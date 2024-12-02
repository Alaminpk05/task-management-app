import 'package:flutter/cupertino.dart';

class textWidget extends StatelessWidget {
  final String text;
  final double fontsize;
  final FontWeight fontwight;
  final Color color;
  const textWidget({
    super.key, required this.text, required this.fontsize,
    required this.fontwight, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(fontWeight: fontwight,color: color,
        fontSize: fontsize,) ,);
  }
}