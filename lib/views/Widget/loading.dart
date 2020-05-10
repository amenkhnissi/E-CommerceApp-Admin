import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: LoadingBouncingGrid.circle(
        backgroundColor: Colors.purple,
        size: 100.0,
      ),
    );
  }
}
