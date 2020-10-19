import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked/stacked.dart';

class DateWeekView extends ViewModelWidget<DateTimePickerViewModel> {
  @override
  Widget build(BuildContext context, DateTimePickerViewModel model) {
    return Container(
      height: 53.0.h,
      child: PageView.builder(
        controller: model.dateScrollController,
        itemCount: model?.dateSlots?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: model.dateSlots[index].days
                  .map((e) => Center(
                        child: InkWell(
                          onTap: !e.enabled
                              ? null
                              : () => model.onTapDate(index, e.index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90.0),
                              border: Border.all(
                                color: e.index == model.selectedDateIndex
                                    ? Theme.of(context).accentColor
                                    : Colors.grey,
                              ),
                              color: e.enabled
                                  ? e.index == model.selectedDateIndex
                                      ? Theme.of(context).accentColor
                                      : Colors.white
                                  : Colors.grey.shade300,
                            ),
                            alignment: Alignment.center,
                            width: 32.0.w,
                            height: 32.0.h,
                            child: Text(
                              '${e.date.day}',
                              style: TextStyle(
                                  fontSize: 14.0.ssp,
                                  fontWeight: FontWeight.w500,
                                  color: e.index == model.selectedDateIndex
                                      ? Colors.white
                                      : Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
