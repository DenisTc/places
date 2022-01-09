import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/ui/res/constants.dart' as constants;

// The custom widget is used to display the loading process
class CustomLoaderWidget extends StatefulWidget {
  const CustomLoaderWidget({Key? key}) : super(key: key);

  @override
  _CustomLoaderWidgetState createState() => _CustomLoaderWidgetState();
}

class _CustomLoaderWidgetState extends State<CustomLoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> rotation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    rotation = Tween(begin: 0.0, end: -pi * 2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: rotation.value,
            child: Image(
              image: AssetImage(constants.pathLoader),
              height: 50,
              width: 50,
            ),
          );
        },
      ),
    );
  }
}
