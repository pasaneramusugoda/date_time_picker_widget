import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DateWeekView extends ViewModelWidget<DateTimePickerViewModel> {
  final BoxConstraints constraints;

  const DateWeekView(this.constraints);

  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    var w = ((constraints.biggest.width - 20) - (32 * 7)) / 7;
    w = (w + w / 7).roundToDouble() + 0.3;
    return Container(
      height: 53.0.h,
      child: PageView.builder(
        controller: viewModel.dateScrollController,
        itemCount: viewModel?.dateSlots?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Container(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(width: w);
                },
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.dateSlots[index].days.length,
                itemBuilder: (context, i) {
                  final e = viewModel.dateSlots[index].days[i];

                  return Center(
                    child: InkWell(
                      onTap: !e.enabled
                          ? null
                          : () => viewModel.selectedDateIndex = e.index,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(
                            color: e.index == viewModel.selectedDateIndex
                                ? Theme.of(context).accentColor
                                : Colors.grey,
                          ),
                          color: e.enabled
                              ? e.index == viewModel.selectedDateIndex
                                  ? Theme.of(context).accentColor
                                  : Colors.white
                              : Colors.grey.shade300,
                        ),
                        alignment: Alignment.center,
                        width: 32.w,
                        height: 32.w,
                        child: Text(
                          '${e.date.day}',
                          style: TextStyle(
                              fontSize: 14.ssp,
                              fontWeight: FontWeight.w500,
                              color: e.index == viewModel.selectedDateIndex
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
