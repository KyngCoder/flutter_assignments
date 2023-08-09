import 'package:flutter/material.dart';

class BMISlider extends StatefulWidget {
  const BMISlider({Key? key, required this.onHeightChanged}) : super(key: key);

  final void Function(num number) onHeightChanged;

  @override
  State<BMISlider> createState() => _BMISliderState();
}

class _BMISliderState extends State<BMISlider> {
  double _currentSliderValue = 0;
  final double minHeight = 50;
  final double maxHeight = 250;
  final int divisions = 100;

  @override
  Widget build(BuildContext context) {
    double height = minHeight + (_currentSliderValue * (maxHeight - minHeight));

    return Slider(
      activeColor: Colors.blue,
      value: _currentSliderValue,
      min: 0,
      max: 1,
      divisions: divisions,
      label: '${height.toStringAsFixed(1)} cm',
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
        widget.onHeightChanged(height);
      },
    );
  }
}



 