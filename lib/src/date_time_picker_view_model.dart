import 'package:date_time_picker_widget/src/date.dart';
import 'package:date_time_picker_widget/src/date_time_picker_type.dart';
import 'package:date_time_picker_widget/src/week.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

class DateTimePickerViewModel extends BaseViewModel {
  final DateTime initialSelectedDate;
  final Function(DateTime) onDateChanged;
  final Function(DateTime) onTimeChanged;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  DateTime _startDate;
  DateTime _endDate;
  DateTime _startTime;
  DateTime _endTime;
  Duration timeInterval;
  final bool is24h;
  final DateTimePickerType type;
  final String timeOutOfRangeError;
  final String datePickerTitle;
  final String timePickerTitle;
  final List<Map<String, dynamic>> weekdays = [
    {'value': DateTime.sunday, 'text': 'S'},
    {'value': DateTime.monday, 'text': 'M'},
    {'value': DateTime.tuesday, 'text': 'T'},
    {'value': DateTime.wednesday, 'text': 'W'},
    {'value': DateTime.thursday, 'text': 'T'},
    {'value': DateTime.friday, 'text': 'F'},
    {'value': DateTime.saturday, 'text': 'S'},
  ];

  DateTimePickerViewModel(this.initialSelectedDate,
      this.onDateChanged,
      this.onTimeChanged,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.timeInterval,
      this.is24h,
      this.type,
      this.timeOutOfRangeError,
      this.datePickerTitle,
      this.timePickerTitle) {
    _startDate = startDate;
    _startTime = startTime;
    _endDate = endDate;
    _endTime = endTime;
  }

  int _selectedWeekday = 0;

  int get selectedWeekday => _selectedWeekday;

  set selectedWeekday(int selectedWeekday) {
    _selectedWeekday = selectedWeekday;
    notifyListeners();
  }

  int _numberOfWeeks = 0;

  int get numberOfWeeks => _numberOfWeeks;

  set numberOfWeeks(int numberOfWeeks) {
    _numberOfWeeks = numberOfWeeks;
    notifyListeners();
  }

  int _numberOfDays = 0;

  int get numberOfDays => _numberOfDays;

  set numberOfDays(int numberOfDays) {
    _numberOfDays = numberOfDays;
    notifyListeners();
  }

  DateTime _selectedDate;

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  int _selectedDateIndex = 0;

  int get selectedDateIndex => _selectedDateIndex;

  set selectedDateIndex(int selectedDateIndex) {
    _selectedDateIndex = selectedDateIndex;
    notifyListeners();
    selectedDate = _findDate(selectedDateIndex);
    selectedWeekday = selectedDate?.weekday;
    onDateChanged(selectedDate);
    _fetchTimeSlots(selectedDate);
  }

  List<Week> _dateSlots = [];

  List<Week> get dateSlots => _dateSlots;

  set dateSlots(List<Week> dateSlots) {
    _dateSlots = dateSlots;
    notifyListeners();
  }

  int _selectedTimeIndex = 0;

  int get selectedTimeIndex => _selectedTimeIndex;

  set selectedTimeIndex(int selectedTimeIndex) {
    _selectedTimeIndex = selectedTimeIndex;
    notifyListeners();
    onTimeChanged(timeSlots[selectedTimeIndex]);
  }

  List<DateTime> _timeSlots = [];

  List<DateTime> get timeSlots => _timeSlots;

  set timeSlots(List<DateTime> timeSlots) {
    _timeSlots = timeSlots;
    notifyListeners();
  }

  final PageController _dateScrollController = PageController();

  PageController get dateScrollController => _dateScrollController;

  final ItemScrollController _timeScrollController = ItemScrollController();

  ItemScrollController get timeScrollController => _timeScrollController;

  final ItemPositionsListener _timePositionsListener =
      ItemPositionsListener.create();

  ItemPositionsListener get timePositionsListener => _timePositionsListener;

  void init() async {
    var currentDateTime = initialSelectedDate ?? DateTime.now();
    var _currentDateTime = DateTime(
        currentDateTime.year, currentDateTime.month, currentDateTime.day);

    //DATE
    if (_startDate == null) _startDate = _currentDateTime;
    _startDate = DateTime(_startDate.year, _startDate.month, _startDate.day);

    if (_endDate == null) _endDate = _startDate.add(Duration(days: 365 * 5));
    _endDate = DateTime(_endDate.year, _endDate.month, _endDate.day);

    numberOfDays = _endDate.difference(_startDate).inDays;
    numberOfWeeks = Jiffy(_endDate).diff(_startDate, Units.WEEK);

    // print('currentDateTime => $currentDateTime');
    // print('_currentDateTime => $_currentDateTime');
    // print('_startDate => $_startDate');
    // print('_endDate => $_endDate');
    // print('numberOfDays => $numberOfDays');
    // print('numberOfWeeks => $numberOfWeeks');

    int dateIndex = 0;
    Week week;

    for (int i = 0; i < numberOfDays; i++) {
      var date = getNextDate(i);
      var w = Jiffy(date).week;

      if (i == 0) {
        week = Week(number: w, days: _fillWeek(date, toStart: true));

        dateSlots.add(week);
      } else if (week.number != w && week.days.length == 7) {
        week = Week(number: w, days: []);

        dateSlots.add(week);
      }

      week.days.add(Date(index: i, date: date));

      if (date.difference(_currentDateTime).inDays == 0) {
        dateIndex = i;
        print('dateIndex => $dateIndex');
      }

      if (i + 1 == numberOfDays) {
        week.days.addAll(_fillWeek(date, toEnd: true));
      }
    }

    Future.delayed(Duration(milliseconds: 500), () {
      if (type == DateTimePickerType.Both || type == DateTimePickerType.Date) {
        if (dateSlots.length > 0) {
          selectedDateIndex = dateIndex;
          dateScrollController.animateToPage(_findWeekIndex(selectedDateIndex),
              duration: Duration(seconds: 1), curve: Curves.linearToEaseOut);
        } else {
          dateSlots = null;
        }
      }
    });

    if (type == DateTimePickerType.Time) _fetchTimeSlots(currentDateTime);
  }

  List<Date> _fillWeek(DateTime date,
      {bool toStart = false, bool toEnd = false}) {
    List<Date> dates = [];

    if (toStart) {
      int i = 1;
      while (Jiffy(date.subtract(Duration(days: i))).week == Jiffy(date).week) {
        dates.insert(
            0,
            Date(
                index: -1,
                date: date.subtract(Duration(days: i)),
                enabled: false));
        i++;
      }
    }

    if (toEnd) {
      int i = 1;
      while (Jiffy(date.add(Duration(days: i))).week == Jiffy(date).week) {
        dates.add(
            Date(index: -1, date: date.add(Duration(days: i)), enabled: false));
        i++;
      }
    }

    return dates;
  }

  int _findWeekIndex(int dateIndex) {
    if (dateSlots != null && dateSlots.isNotEmpty) {
      return dateSlots.indexWhere(
          (w) => w.days.where((d) => d.index == dateIndex).toList().length > 0);
    } else {
      return 0;
    }
  }

  DateTime _findDate(int dateIndex) {
    print('_findDate => $dateIndex');
    if (dateSlots != null && dateSlots.isNotEmpty) {
      var w = dateSlots
          .where((e) =>
              e.days.where((d) => d.index == dateIndex).toList().length == 1)
          .toList();

      if (w != null && w.length == 1) {
        return w[0].days.firstWhere((e) => e.index == dateIndex).date;
      }
    }

    return null;
  }

  void _fetchTimeSlots(DateTime currentDateTime) {
    //TIME
    if (startTime == null)
      _startTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
      );
    if (endTime == null)
      _endTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        24,
      );

    if (startTime != null || endTime != null) {
      // current time is not today
      if (currentDateTime.day - DateTime.now().day > 0) {
        if (startTime != null) {
          currentDateTime = _startTime = DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            startTime.hour,
            startTime.minute,
          );
        }
        if (endTime != null)
          _endTime = DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            endTime.hour,
            endTime.minute,
          );
      } else if (currentDateTime
          .isBefore(DateTime.now().add(Duration(seconds: 5)))) {
        // current time is today
        currentDateTime = _startTime = DateTime(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          DateTime.now().hour,
          DateTime.now().minute,
        );

        if (startTime != null && currentDateTime.hour < startTime.hour)
          currentDateTime = _startTime = DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            startTime.hour,
            startTime.minute,
          );

        if (endTime != null) {
          _endTime = DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            endTime.hour,
            endTime.minute,
          );
        } else {
          _endTime = DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            24,
            0,
          );
        }
      }
    }

    int timeIndex = -1;
    timeSlots = [];
    for (int i = 0; i < _getTimeSlotsCount(); i++) {
      var time = _getNextTime(i);
      timeSlots.add(time);
      if (timeIndex == -1 &&
          (time.difference(currentDateTime).inMinutes <=
                  timeInterval.inMinutes ||
              time.difference(currentDateTime).inMinutes <= 0)) timeIndex = i;
    }

    Future.delayed(Duration(milliseconds: 500), () {
      if (type == DateTimePickerType.Both || type == DateTimePickerType.Time) {
        if (timeSlots.length > 0) {
          selectedTimeIndex = timeIndex == -1 ? 0 : timeIndex;
          timeScrollController?.scrollTo(
              index: selectedTimeIndex, duration: Duration(seconds: 1));
        } else {
          timeSlots = null;
        }
      }
    });
  }

  int _getTimeSlotsCount() {
    return (_endTime.difference(_startTime).inMinutes ~/ timeInterval.inMinutes)
        .toInt();
  }

  DateTime _getNextTime(int index) {
    var dt = _startTime.add(
        Duration(minutes: (60 - _startTime.minute) % timeInterval.inMinutes));
    dt = dt.add(Duration(minutes: timeInterval.inMinutes * index));

    return dt;
  }

  DateTime getNextDate(int index) {
    return _startDate.add(Duration(days: index));
  }

  void onTapDate(int weekIndex, int dateIndex) {
    selectedDateIndex = dateIndex;
  }

  void onTapTime(int index) {
    selectedTimeIndex = index;
  }

  void onClickNext() {
    var dt = Jiffy(selectedDate).add(months: 1);
    var diff = Jiffy(dt).diff(selectedDate, Units.DAY);

    if (numberOfDays < selectedDateIndex + diff)
      selectedDateIndex = numberOfDays - 1;
    else
      selectedDateIndex += diff;

    dateScrollController.animateToPage(_findWeekIndex(selectedDateIndex),
        duration: Duration(seconds: 1), curve: Curves.linearToEaseOut);
  }

  void onClickPrevious() {
    var dt = Jiffy(selectedDate).subtract(months: 1);
    var diff = Jiffy(selectedDate).diff(dt, Units.DAY);

    if (selectedDateIndex < diff)
      selectedDateIndex = 0;
    else
      selectedDateIndex -= diff;

    dateScrollController.animateToPage(_findWeekIndex(selectedDateIndex),
        duration: Duration(seconds: 1), curve: Curves.linearToEaseOut);
  }
}
