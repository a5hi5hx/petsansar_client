import 'package:flutter/material.dart';
import '../exports.dart';
class ShimmerWidget extends StatefulWidget {
  double hei;
   ShimmerWidget({super.key, required this.hei});

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Expanded(
        child: ListView.builder(
           scrollDirection: Axis.vertical,
          shrinkWrap: true,
         itemCount: 5,
         itemBuilder: (context, index) {
          return Card(
           elevation: 1.0,
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
           ),
           child:  SizedBox(height: widget.hei),
          );
         },
        ),
      ),
     );
  }
}