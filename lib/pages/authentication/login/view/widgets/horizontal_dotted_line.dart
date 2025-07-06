import 'package:flutter/material.dart';
import 'package:tulsi_hotel/widgets/custom_views/dotted_line_horizontal_widget.dart';
class HorizontalDottedLine extends StatelessWidget {
  const HorizontalDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedLineHorizontalWidget(
      color: Colors.grey,
      height: 0.6,
      dotWidth: 4,
      spacing: 4,
    );
  }
}
