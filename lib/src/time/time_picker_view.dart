import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

class TimePickerView extends ViewModelWidget<DateTimePickerViewModel> {
  const TimePickerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, DateTimePickerViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
          child: Text(
            '${model.timePickerTitle}',
            style: TextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 45.0.h,
          alignment: Alignment.center,
          child: model.timeSlots == null
              ? Text(
                  model.timeOutOfRangeError,
                  style: TextStyle(color: Colors.black87),
                )
              : ScrollablePositionedList.builder(
                  itemScrollController: model.timeScrollController,
                  itemPositionsListener: model.timePositionsListener,
                  scrollDirection: Axis.horizontal,
                  itemCount: model.timeSlots.length,
                  itemBuilder: (BuildContext context, int index) {
                    var date = model.timeSlots[index];
                    return InkWell(
                      onTap: () => model.onTapTime(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        margin: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: index == model.selectedTimeIndex
                                ? Theme.of(context).accentColor
                                : Colors.grey,
                          ),
                          color: index == model.selectedTimeIndex
                              ? Theme.of(context).accentColor
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${DateFormat(model.is24h ? 'HH:mm' : 'hh:mm aa').format(date)}',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: index == model.selectedTimeIndex
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
