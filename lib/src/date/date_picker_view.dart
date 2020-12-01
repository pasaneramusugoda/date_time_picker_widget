import 'package:date_time_picker_widget/src/date/date_week_view.dart';
import 'package:date_time_picker_widget/src/date/date_weekdays_view.dart';
import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class DatePickerView extends ViewModelWidget<DateTimePickerViewModel> {
  final BoxConstraints constraints;

  const DatePickerView({Key key, @required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                bottom: 16,
              ),
              child: Text(
                '${viewModel.datePickerTitle}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.navigate_before,
                          color: Colors.black,
                        ),
                        onPressed: viewModel.onClickPrevious),
                    Text(
                      viewModel.selectedDate != null
                          // ignore: lines_longer_than_80_chars
                          ? '${DateFormat('MMMM yyyy').format(viewModel.selectedDate)}'
                          : '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                        onPressed: viewModel.onClickNext),
                  ],
                ),
              ),
            ),
          ],
        ),
        DateWeekdaysView(),
        DateWeekView(constraints),
      ],
    );
  }
}
