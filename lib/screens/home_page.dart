import 'package:flutter/material.dart';
import 'package:habit_tracker/components/floating_action_button.dart';
import 'package:habit_tracker/components/habit_dialog.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/monthly_summary.dart';
import 'package:habit_tracker/data/habits_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = HabitsDatabase();
  final _myBox = Hive.box('My_Habits');
  final controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get('CURRENT_HABIT_LIST') == null) {
      db.createNewHabitdatabase();
    } else {
      db.loadData();
    }

    db.updateDatabase();

    super.initState();
  }

  void onCheckboxPressed(int index, bool? value) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) => HabitDialog(
              hintText: 'Enter New Habit...',
              controller: controller,
              save: save,
              cancel: cancel,
            ));
  }

  void save() {
    setState(() {
      db.todaysHabitList.add([controller.text, false]);
      Navigator.pop(context);
      controller.clear();
    });
    db.updateDatabase();
  }

  void cancel() {
    Navigator.pop(context);
    controller.clear();
  }

  void editHabit(int index) {
    showDialog(
      context: context,
      builder: (context) => HabitDialog(
          hintText: db.todaysHabitList[index][0],
          controller: controller,
          save: () => saveNewHabit(index),
          cancel: cancel),
    );
  }

  void saveNewHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = controller.text;
      Navigator.pop(context);
      controller.clear();
    });
    db.updateDatabase();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FAB(onPressed: () => createNewHabit()),
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            MonthlySummary(datasets: db.heatMapDatasets, startDate: _myBox.get('START_DATE')),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todaysHabitList.length,
              itemBuilder: (context, index) => HabitTile(
                habitName: db.todaysHabitList[index][0],
                isFinished: db.todaysHabitList[index][1],
                onChanged: (value) => onCheckboxPressed(index, value),
                onSavePressed: (context) => editHabit(index),
                onDeletePressed: (context) => deleteHabit(index),
              ),
            ),
          ],
        ));
  }
}
