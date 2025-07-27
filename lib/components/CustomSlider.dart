// In your CustomSlider.dart file
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final String label;
  final ValueChanged<double> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final TextStyle? labelStyle;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(label, style: labelStyle),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Slider(
                      value: value,
                      min: 0,
                      max: 180,
                      divisions: 180,
                      label: value.round().toString(),
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      onChanged: onChanged,
                    ),
                  ),
                ),
              ),

              Text(value.round().toString(), style: labelStyle),
            ],
          ),
        ],
      ),
    );
  }
}
