import 'package:flutter/material.dart';

class HabitDialog extends StatelessWidget {
  HabitDialog(
      {super.key,
      required this.controller,
      required this.save,
      required this.cancel,
      required this.hintText});

  final controller;
  Function()? save;
  Function()? cancel;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:  TextStyle(color: Colors.grey[600]),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green)),
          ),
          controller: controller),
      actions: [
        MaterialButton(
            color: Colors.black,
            onPressed: save,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            )),
        MaterialButton(
            color: Colors.black,
            onPressed: cancel,
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
