import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  HabitTile(
      {super.key,
      required this.habitName,
      required this.isFinished,
      required this.onChanged,
      required this.onSavePressed,
      required this.onDeletePressed});

  String habitName;
  bool? isFinished;
  Function(bool?)? onChanged;
  Function(BuildContext)? onSavePressed;
  Function(BuildContext)? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12.0),
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              onPressed: onSavePressed,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(12.0),
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              onPressed: onDeletePressed,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color:   Colors.white , borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Checkbox(
                value: isFinished,
                onChanged: onChanged,
              ),
              Text(habitName)
            ],
          ),
        ),
      ),
    );
  }
}
