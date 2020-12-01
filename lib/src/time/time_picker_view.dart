import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

class TimePickerView extends ViewModelWidget<DateTimePickerViewModel> {
  const TimePickerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          child: Text(
            '${viewModel.timePickerTitle}',
            style: TextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 45.0.h,
          alignment: Alignment.center,
          child: viewModel.timeSlots == null
              ? Text(
                  viewModel.timeOutOfRangeError,
                  style: const TextStyle(color: Colors.black87),
                )
              : ScrollablePositionedList.builder(
                  itemScrollController: viewModel.timeScrollController,
                  itemPositionsListener: viewModel.timePositionsListener,
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.timeSlots.length,
                  itemBuilder: (context, index) {
                    final date = viewModel.timeSlots[index];
                    return InkWell(
                      onTap: () => viewModel.selectedTimeIndex = index,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        margin: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: index == viewModel.selectedTimeIndex
                                ? Theme.of(context).accentColor
                                : Colors.grey,
                          ),
                          color: index == viewModel.selectedTimeIndex
                              ? Theme.of(context).accentColor
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          // ignore: lines_longer_than_80_chars
                          '${DateFormat(viewModel.is24h ? 'HH:mm' : 'hh:mm aa')
                              .format(date)}',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: index == viewModel.selectedTimeIndex
                                  ? Colors.white
                                  : Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
