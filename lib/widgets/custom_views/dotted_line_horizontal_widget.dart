import 'package:flutter/material.dart';

class DottedLineHorizontalWidget extends StatelessWidget {
  final double height;
  final Color color;
  final double dotWidth;
  final double spacing;

  const DottedLineHorizontalWidget({
    this.height = 1,
    this.color = Colors.black,
    this.dotWidth = 4,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final count = (boxWidth / (dotWidth + spacing)).floor();
        return Wrap(
          spacing: spacing,
          children: List.generate(count, (_) {
            return Container(
              width: dotWidth,
              height: height,
              color: color,
            );
          }),
        );
      },
    );
  }
}
