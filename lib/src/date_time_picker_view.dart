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

  const DateTimePicker({
    Key key,
    this.initialSelectedDate,
    @required this.onDateChanged,
    @required this.onTimeChanged,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.timeInterval = const Duration(minutes: 1),
    this.is24h = false,
    this.type = DateTimePickerType.Both,
    this.timeOutOfRangeError = 'Out of Range',
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DateTimePickerViewModel model, Widget child) {
    try {
      ScreenUtil();
    } catch (e) {
      //iPhoneXR Scree Size
      ScreenUtil.init(context,
          designSize: Size(414, 896), allowFontScaling: true);
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (type == DateTimePickerType.Both ||
              type == DateTimePickerType.Date)
            DatePickerView(),
          if (type == DateTimePickerType.Both) SizedBox(height: 16.0),
          if (type == DateTimePickerType.Both ||
              type == DateTimePickerType.Time)
            TimePickerView(),
        ],
      ),
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
      );

  @override
  void onViewModelReady(DateTimePickerViewModel model) => model.init();
}
