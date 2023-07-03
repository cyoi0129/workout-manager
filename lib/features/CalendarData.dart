import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'WorkoutMasterData.dart';
import 'WorkoutTaskData.dart';

class CalendarModel extends ChangeNotifier {
  List<WorkoutTaskModel> _taskList = [];
  List<WorkoutMasterModel> _masterList = [];
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {};

  WorkoutMasterModel _getWorkoutMasterItem(int target) {
    return _masterList.firstWhere((master) => master.id == target);
  }

  void _addEvents(WorkoutTaskModel task) {
    late DateTime targetDate;
    DateTime start = DateTime.parse(task.date);

    targetDate = start.add(const Duration(days: 0));
    DateTime key =
        DateTime.utc(targetDate.year, targetDate.month, targetDate.day);
    String title = task.weight == 0
        ? _getWorkoutMasterItem(task.master).name
        : '${_getWorkoutMasterItem(task.master).name} (${task.weight.toString()} kg)';
    String value = '${title}: ${task.rep} 回 x ${task.sets} セット';
    if (_events.containsKey(key)) {
      if (!_events[key]!.contains(value)) {
        _events[key]?.add(value);
      }
    } else {
      _events[key] = [value];
    }
  }

  void _initData() {
    _events = {};
  }

  void _setEventData() {
    _initData();
    if (_taskList.isNotEmpty) {
      for (WorkoutTaskModel task in _taskList) {
        _addEvents(task);
      }
    }
  }

  setCalendarEvents(
      List<WorkoutMasterModel> masterData, List<WorkoutTaskModel> taskData) {
    _masterList = masterData;
    _taskList = taskData;
    _setEventData();
  }

  List getEventForDay(DateTime day) {
    return _events[day] ?? [];
  }

  DateTime getFocusedDay() {
    return _focusedDay;
  }

  DateTime getSelectedDay() {
    return _selectedDay;
  }

  CalendarFormat getCalendarFormat() {
    return _calendarFormat;
  }

  getCurrentEvents() {
    return getEventForDay(_selectedDay);
  }

  void setFocusedDay(DateTime date) {
    _focusedDay = date;
  }

  void setSelectedDay(DateTime date) {
    if (date != _focusedDay) {
      _selectedDay = date;
      notifyListeners();
    }
  }

  void setCalendarFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }
}
