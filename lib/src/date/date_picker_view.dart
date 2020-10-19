import 'package:date_time_picker_widget/src/date/date_week_view.dart';
import 'package:date_time_picker_widget/src/date/date_weekdays_view.dart';
import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class DatePickerView extends ViewModelWidget<DateTimePickerViewModel> {
  const DatePickerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, DateTimePickerViewModel model) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                bottom: 16.0,
              ),
              child: Text(
                'Pick a Date',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.navigate_before,
                          color: Colors.black,
                        ),
                        onPressed: model.onClickPrevious),
                    Text(
                      model.selectedDate != null
                          ? '${DateFormat('MMMM yyyy').format(model.selectedDate)}'
                          : '',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                        onPressed: model.onClickNext),
                  ],
                ),
              ),
            ),
          ],
        ),
        DateWeekdaysView(),
        DateWeekView(),
      ],
    );
  }
}
