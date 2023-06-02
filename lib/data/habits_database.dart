import 'package:habit_tracker/DateTIme/date_time.dart';
import 'package:hive/hive.dart';

final _myBox = Hive.box('My_Habits');

class HabitsDatabase {
  Map<DateTime, int> heatMapDatasets = {};
  List todaysHabitList = [];

  void createNewHabitdatabase() {
    todaysHabitList = [
      ['Read Book', false],
      ['Code', false]
    ];

    _myBox.put('START_DATE', todaysDateFormatted());
  }

  void loadData() {
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _myBox.get('CURRENT_HABIT_LIST');
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    } else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  void updateDatabase() {
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    _myBox.put('CURRENT_HABIT_LIST', todaysHabitList);


      habitCompletePercentage();

       loadHeatMap();
  }

  void habitCompletePercentage() {
    int countfinished = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countfinished++;
      }
    }
    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (countfinished / todaysHabitList.length).toStringAsFixed(1);

    _myBox.put('PERCENTAGE_SUMMARY_${todaysDateFormatted()}', percent);
  }

  void loadHeatMap() {
    DateTime startDate = createNewHabitDatetimeObject(_myBox.get('START_DATE'));

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDatetimeToString(
        startDate.add(
          Duration(days: i),
        ),
      );

      double strengthAsPercentage = double.parse(
          _myBox.get('PERCENTAGE_SUMMARY_${todaysDateFormatted()}') ?? '0.0');

      int year = startDate.add(Duration(days: i)).year;

      int month = startDate.add(Duration(days: i)).month;

      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercentage).toInt()
      };

      heatMapDatasets.addEntries(percentForEachDay.entries);

      print(heatMapDatasets);
    }
  }
}
