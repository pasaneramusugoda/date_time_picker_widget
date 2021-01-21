import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DateWeekdaysView extends ViewModelWidget<DateTimePickerViewModel> {
  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: viewModel.weekdays
              .map((e) => Container(
                    width: 32,
                    child: Text(
                      '${e['text']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: e['value'] == viewModel.selectedWeekday
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
