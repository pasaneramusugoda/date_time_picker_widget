import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked/stacked.dart';

class DateWeekdaysView extends ViewModelWidget<DateTimePickerViewModel> {
  @override
  Widget build(BuildContext context, DateTimePickerViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: model.weekdays
              .map((e) => Container(
                    width: 32.0.w,
                    child: Text(
                      '${e['text']}',
                      style: TextStyle(
                        fontSize: 18.0.ssp,
                        color: e['value'] == model.selectedWeekday
                            ? Colors.black
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
