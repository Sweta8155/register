import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Text text;
  final Color color;
  final Null Function() onPressed;
  final Image? icon;

  const MyButton(
      {super.key,
      required this.text,
      required this.color,
      this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: icon!,
            ),
          ],
          text
        ]),
      ),
    );
  }
}
