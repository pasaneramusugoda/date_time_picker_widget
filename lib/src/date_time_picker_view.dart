import 'package:date_time_picker_widget/src/date/date_picker_view.dart';
import 'package:date_time_picker_widget/src/date_time_picker_type.dart';
import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:date_time_picker_widget/src/time/time_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stacked/stacked.dart';

class DateTimePicker extends ViewModelBuilderWidget<DateTimePickerViewModel> {
  final DateTime? initialSelectedDate;
  final Function(DateTime date)? onDateChanged;
  final Function(DateTime time)? onTimeChanged;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final Duration timeInterval;
  final bool is24h;
  final DateTimePickerType type;
  final String timeOutOfRangeError;
  final String datePickerTitle;
  final String timePickerTitle;
  final int numberOfWeeksToDisplay;
  final List<String>? customStringWeekdays;
  final String? locale;

  /// Constructs a DateTimePicker
  const DateTimePicker({
    Key? key,
    this.initialSelectedDate,
    this.onDateChanged,
    this.onTimeChanged,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.timeInterval = const Duration(minutes: 1),
    this.is24h = false,
    this.type = DateTimePickerType.Both,
    this.timeOutOfRangeError = 'Out of Range',
    this.datePickerTitle = 'Pick a Date',
    this.timePickerTitle = 'Pick a Time',
    this.numberOfWeeksToDisplay = 1,
    this.customStringWeekdays,
    this.locale,

  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DateTimePickerViewModel viewModel, Widget? child) {
    if (type == DateTimePickerType.Both &&
        (onDateChanged == null || onTimeChanged == null)) {
      throw Exception('Ensure both onDateChanged and onTimeChanged are not null'
          ' when type is DateTimePickerType.Both');
    }

    if (type == DateTimePickerType.Date && onDateChanged == null) {
      throw Exception('Ensure onDateChanged is not null when type is '
          'DateTimePickerType.Date');
    }

    if (type == DateTimePickerType.Time && onTimeChanged == null) {
      throw Exception('Ensure onTimeChanged is not null when type is '
          'DateTimePickerType.Time');
    }

    if (initialSelectedDate != null &&
        startDate != null && !(initialSelectedDate!.isAfter(startDate!) || initialSelectedDate!.isAtSameMomentAs(startDate!))){
      throw Exception('initialSelectedDate must be a date after or equals startDate');
    }

    if (initialSelectedDate != null &&
        endDate != null &&
        (!initialSelectedDate!.isBefore(endDate!))) {
      throw Exception('initialSelectedDate must be a date before endDate');
    }

    if (startDate != null && endDate != null && !endDate!.isAfter(startDate!)) {
      throw Exception('endDate must be a date after startDate');
    }

    if (startTime != null && endTime != null && !endTime!.isAfter(startTime!)) {
      throw Exception('endTime must be a time after startTime');
    }

    if (customStringWeekdays != null && customStringWeekdays!.length != 7) {
      throw Exception('customStringWeekdays must containt 7 items');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (type == DateTimePickerType.Both ||
                  type == DateTimePickerType.Date)
                DatePickerView(constraints: constraints, locale: locale,),
              if (type == DateTimePickerType.Both) const SizedBox(height: 16),
              if (type == DateTimePickerType.Both ||
                  type == DateTimePickerType.Time)
                const TimePickerView(),
            ],
          ),
        );
      },
    );
  }

  @override
  DateTimePickerViewModel viewModelBuilder(BuildContext context) =>
      DateTimePickerViewModel(
        initialSelectedDate,
        onDateChanged,
        onTimeChanged,
        startDate,
        endDate,
        startTime,
        endTime,
        timeInterval,
        is24h,
        type,
        timeOutOfRangeError,
        datePickerTitle,
        timePickerTitle,
        customStringWeekdays,
        numberOfWeeksToDisplay,
        locale,
      );

  @override
  void onViewModelReady(DateTimePickerViewModel viewModel) => viewModel.init();
}
