import 'package:date_time_picker_widget/src/date/date_picker_view.dart';
import 'package:date_time_picker_widget/src/date_time_picker_type.dart';
import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:date_time_picker_widget/src/time/time_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class DateTimePicker extends ViewModelBuilderWidget<DateTimePickerViewModel> {
  final DateTime initialSelectedDate;
  final Function(DateTime date) onDateChanged;
  final Function(DateTime time) onTimeChanged;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final Duration timeInterval;
  final bool is24h;
  final DateTimePickerType type;
  final String timeOutOfRangeError;
  final String datePickerTitle;
  final String timePickerTitle;

  /// Constructs a DateTimePicker
  const DateTimePicker({
    Key key,
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
  })  : assert(type != null),
        super(key: key);

  @override
  Widget builder(
      BuildContext context, DateTimePickerViewModel model, Widget child) {
    if (type == DateTimePickerType.Both &&
        (onDateChanged == null || onTimeChanged == null)) {
      throw 'Ensure both onDateChanged and onTimeChanged are not null when type is DateTimePickerType.Both';
    }
    if (type == DateTimePickerType.Date && onDateChanged == null)
      throw 'Ensure onDateChanged is not null when type is DateTimePickerType.Date';

    if (type == DateTimePickerType.Time && onTimeChanged == null)
      throw 'Ensure onTimeChanged is not null when type is DateTimePickerType.Time';

    try {
      ScreenUtil();
    } catch (e) {
      //iPhoneXR Scree Size
      ScreenUtil.init(context,
          designSize: Size(414, 896), allowFontScaling: true);
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
                DatePickerView(constraints: constraints),
              if (type == DateTimePickerType.Both) SizedBox(height: 16.0),
              if (type == DateTimePickerType.Both ||
                  type == DateTimePickerType.Time)
                TimePickerView(),
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
      );

  @override
  void onViewModelReady(DateTimePickerViewModel model) => model.init();
}
