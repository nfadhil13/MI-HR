import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class ResponsiveWidget extends StatelessWidget {

  final Widget portrait;
  final Widget landscape;


  ResponsiveWidget({
    required this.portrait, required this.landscape
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape ? landscape : portrait;
  }
}
