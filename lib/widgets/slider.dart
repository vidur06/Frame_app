import 'package:flutter/material.dart';

class SliderData extends StatelessWidget {
  const SliderData({
    super.key,
    required this.icon,
    required this.name,
    required this.max,
    required this.min,
    required this.value,
    required this.onChanged,
  });
  final IconData icon;
  final String name;
  final double max;
  final double min;
  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.blue,
            ),
            Text(
              name,
              style: const TextStyle(color: Colors.blue),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            max: max,
            min: min,
            value: value,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(value.toStringAsFixed(2)),
        ),
      ],
    );
  }
}
