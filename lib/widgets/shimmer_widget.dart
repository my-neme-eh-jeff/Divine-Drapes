import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))
          )});

  const ShimmerWidget.circular(
      {required this.height,
      required this.width,
      this.shapeBorder = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)))});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ));
  }
}
