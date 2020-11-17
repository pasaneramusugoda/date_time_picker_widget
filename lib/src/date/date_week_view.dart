import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked/stacked.dart';

class DateWeekView extends ViewModelWidget<DateTimePickerViewModel> {
  final BoxConstraints constraints;

  DateWeekView(this.constraints);

  @override
  Widget build(BuildContext context, DateTimePickerViewModel model) {
    var w = ((constraints.biggest.width - 20.w) - (32.w * 7)) / 7;
    w = (w + w / 7).roundToDouble() + 0.3.w;
    return Container(
      height: 53.0.h,
      child: PageView.builder(
        controller: model.dateScrollController,
        itemCount: model?.dateSlots?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Container(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(width: w);
                },
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.dateSlots[index].days.length,
                itemBuilder: (context, i) {
                  var e = model.dateSlots[index].days[i];

                  return Center(
                    child: InkWell(
                      onTap: !e.enabled
                          ? null
                          : () => model.onTapDate(index, e.index),
                      child: Container(
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
                        height: 32.0.w,
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
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
