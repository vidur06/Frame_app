import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LableWidget extends StatelessWidget {
  LableWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.color1,
    required this.color2,
  }) : super(key: key);
  String text = "";
  Color color1;
  Color color2;
  Icon icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110,
          width: 110,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color1,
                color2,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}


