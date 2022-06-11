import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  const Btn({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  final void Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CupertinoButton(
          color: Colors.lightBlue.shade100,
          child: Text(label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
