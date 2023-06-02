import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  FAB({super.key, required this.onPressed});
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: onPressed,
      child: const Icon(Icons.add));
  }
}
