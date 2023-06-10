import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../components/Header.dart';
import '../components/Footer.dart';
import 'package:provider/provider.dart';
import '../features/CalendarData.dart';
import '../features/MasterData.dart';
import '../features/TaskData.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget _buildEventsMarker(DateTime date, List events) {
    return Positioned(
      right: 5,
      bottom: 5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red[300],
        ),
        width: 16.0,
        height: 16.0,
        child: Center(
          child: Text(
            '${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    final MasterData _masterData = context.watch<MasterData>();
    final TaskData _taskData = context.watch<TaskData>();
    final CalendarModel _calendarData = context.watch<CalendarModel>();
    _taskData.setGetAllTask();
    _calendarData.setCalendarEvents(
        _masterData.getMasterList(), _taskData.getAllTaskList());

    return Scaffold(
      appBar: const Header(title: 'カレンダー'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: _calendarData.getFocusedDay(),
                calendarFormat: _calendarData.getCalendarFormat(),
                eventLoader: (date) {
                  return _calendarData.getEventForDay(date);
                },
                onFormatChanged: (format) =>
                    {_calendarData.setCalendarFormat(format)},
                selectedDayPredicate: (day) {
                  return isSameDay(_calendarData.getSelectedDay(), day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_calendarData.getSelectedDay(), selectedDay)) {
                    _calendarData.setSelectedDay(selectedDay);
                    _calendarData.setFocusedDay(focusedDay);
                  }
                },
                calendarBuilders:
                    CalendarBuilders(markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return _buildEventsMarker(date, events);
                  }
                })),
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(4.0, 24.0, 4.0, 24.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _calendarData.getCurrentEvents().length,
                itemBuilder: (context, index) {
                  final event = _calendarData.getCurrentEvents()[index];
                  return Card(
                    child: ListTile(
                      title: Text(event),
                    ),
                  );
                },
              ),
            )),
          ]),
      bottomNavigationBar: const Footer(current: 0),
    );
  }
}
