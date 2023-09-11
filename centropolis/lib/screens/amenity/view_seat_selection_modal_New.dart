import 'package:centropolis/models/view_seat_selection_model.dart';
import 'package:centropolis/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../models/selected_seat_model.dart';
import '../../providers/user_provider.dart';
import '../../utils/custom_colors.dart';

class ViewSeatSelectionModalScreenNew extends StatefulWidget {
  final List<ViewSeatSelectionModel>? viewSeatSelectionListItem;
  final List<dynamic> timeSlotList;
  final List<dynamic> selectedSeatList;
  final String? usageTimeSelectedValue;
  final String? selectedSeatsValue;
  final String? totalTimeSelectedValue;
  final List<String>? usageTimeList;
  final List<SelectedSeatModel> selectedSeatListForView;

  const ViewSeatSelectionModalScreenNew(
      this.viewSeatSelectionListItem,
      this.timeSlotList,
      this.selectedSeatList,
      this.usageTimeSelectedValue,
      this.selectedSeatsValue,
      this.totalTimeSelectedValue,
      this.usageTimeList,
      this.selectedSeatListForView,
      {super.key});

  @override
  State<ViewSeatSelectionModalScreenNew> createState() =>
      _ViewSeatSelectionModalScreenState();
}

class _ViewSeatSelectionModalScreenState
    extends State<ViewSeatSelectionModalScreenNew> {
  late String gender;
  bool selected = false;
  int selectedIndex = 0;
  List<String> selectedTimeRangList = [];

  @override
  void initState() {
    super.initState();
    var user = Provider.of<UserProvider>(context, listen: false);
    gender = user.userData['gender'].toString();
    debugPrint("Gender  ====> $gender");
    debugPrint("Time slot list  ====> ${widget.timeSlotList}");
    debugPrint("Time list length ====> ${widget.timeSlotList.length}");
    debugPrint("usageTimeSelectedValue ====> ${widget.usageTimeSelectedValue}");
    debugPrint("selectedSeatsValue ====> ${widget.selectedSeatsValue}");
    debugPrint("totalTimeSelectedValue ====> ${widget.totalTimeSelectedValue}");
    debugPrint("usageTimeList ====> ${widget.usageTimeList}");
    debugPrint("selectedSeatList ====> ${widget.selectedSeatList}");
    setSelectionTimeRange();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height / 1.2;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      insetPadding: const EdgeInsets.only(left: 18.0, right: 18.0),
      contentPadding: const EdgeInsets.only(
        top: 10,
        bottom: 20.0,
      ),
      scrollable: true,
      content: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  color: CustomColors.whiteColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        tr("seatSelection"),
                        style: const TextStyle(
                          fontSize: 16,
                          color: CustomColors.textColor8,
                          fontFamily: 'SemiBold',
                        ),
                      )),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.square,
                                size: 15,
                                color: CustomColors.textColor9,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                tr("select"),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: CustomColors.greyColor1,
                                  fontFamily: 'Regular',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.square_outlined,
                                size: 15,
                                color: CustomColors.textColor9,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                tr("selectable"),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: CustomColors.greyColor1,
                                  fontFamily: 'Regular',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.square,
                                size: 15,
                                color: CustomColors.borderColor,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                tr("closed"),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: CustomColors.greyColor1,
                                  fontFamily: 'Regular',
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  color: CustomColors.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            gender == "f"
                                ? tr("sleepingRoom(Female)")
                                : tr("sleepingRoom(Male)"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                        ),
                      ),






                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              height: height,
                              margin: const EdgeInsets.only(top: 20, left: 10),
                              child: AlignedGridView.count(
                                crossAxisCount: widget.timeSlotList.length,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    widget.viewSeatSelectionListItem!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: setItemWidth(index),
                                    height: 34,
                                    margin: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: setBackgroundColor(
                                          widget
                                              .viewSeatSelectionListItem?[index]
                                              .available,
                                          widget
                                              .viewSeatSelectionListItem?[index]
                                              .slot
                                              .toString(),
                                          widget
                                              .viewSeatSelectionListItem?[index]
                                              .slotRange
                                              .toString(),
                                          widget
                                              .viewSeatSelectionListItem?[index]
                                              .seat
                                              .toString()),
                                      border: Border.all(
                                          color: setBorderColor(
                                              widget
                                                  .viewSeatSelectionListItem?[
                                                      index]
                                                  .available,
                                              widget
                                                  .viewSeatSelectionListItem?[
                                                      index]
                                                  .slot
                                                  .toString(),
                                              widget
                                                  .viewSeatSelectionListItem?[
                                                      index]
                                                  .slotRange
                                                  .toString(),
                                              widget
                                                  .viewSeatSelectionListItem?[
                                                      index]
                                                  .seat
                                                  .toString()),
                                          width: 1.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        setTextValue(index),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: CustomColors.textColorBlack2,
                                          fontFamily: 'Regular',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 35,
                              margin: const EdgeInsets.only(
                                  top: 5, bottom: 10, left: 10),
                              child: AlignedGridView.count(
                                // physics: const NeverScrollableScrollPhysics(),
                                // shrinkWrap: true,
                                crossAxisCount: 1,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.selectedSeatListForView.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: setItemWidthForSeatView(index),
                                    height: 34,
                                    margin: const EdgeInsets.all(6),
                                    child: Center(
                                      child: Text(
                                        setTextValueForSeatView(index),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: CustomColors.textColorBlack2,
                                          fontFamily: 'Regular',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )







                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  setBackgroundColor(
      bool? availableStatus, String? slot, String? slotRange, String? seat) {
    if (availableStatus == false) {
      return CustomColors.borderColor;
    } else {
      if (widget.selectedSeatsValue == seat) {
        for (int i = 0; i < selectedTimeRangList.length; i++) {
          // debugPrint(
          //     "---selectedTimeRangList[i]-------------${selectedTimeRangList[i]}");
          // debugPrint("---slotRange----------------$slotRange");
          if (selectedTimeRangList[i].toString().trim() ==
              slotRange?.toString().trim()) {
            return CustomColors.textColor9;
          }
          // else{
          //   return CustomColors.whiteColor;
          // }
        }
      } else if (slot == "") {
        return CustomColors.backgroundColor;
      } else {
        return CustomColors.whiteColor;
      }
    }
  }

  setBorderColor(
      bool? availableStatus, String? slot, String? slotRange, String? seat) {
    if (availableStatus == false) {
      return CustomColors.borderColor;
    } else {
      if (widget.selectedSeatsValue == seat) {
        // if(slotRange != null || selectedTimeRangList.isNotEmpty) {
        for (int i = 0; i < selectedTimeRangList.length; i++) {
          if (selectedTimeRangList[i] == slotRange) {
            return CustomColors.textColor9;
          } else {
            if (slot == "") {
              return CustomColors.backgroundColor;
            } else {
              return CustomColors.textColor9;
            }
          }
        }
        // }
        // else{
        //   return CustomColors.baseColor;
        // }
      } else if (slot == "") {
        return CustomColors.backgroundColor;
      } else {
        return CustomColors.textColor9;
      }
    }
  }

  String setTextValue(int index) {
    if (widget.viewSeatSelectionListItem?[index].slotRange.toString() != "" &&
        widget.viewSeatSelectionListItem![index].seat == 0) {
      return '${widget.viewSeatSelectionListItem?[index].slotRange.toString()}';
    } else {
      if (widget.viewSeatSelectionListItem![index].seat! > 0 &&
          widget.viewSeatSelectionListItem?[index].slotRange.toString() == "") {
        return '${widget.viewSeatSelectionListItem?[index].seat.toString()}';
      } else if (widget.viewSeatSelectionListItem![index].seat! == 0 &&
          widget.viewSeatSelectionListItem?[index].slotRange.toString() == "") {
        return "Seat ";
      } else {
        return "";
      }
    }
  }

  void setSelectionTimeRange() {
    String hr = "00";
    String min = "00";
    selectedTimeRangList.clear();
    String? timeValue =
        widget.totalTimeSelectedValue!.replaceAll(RegExp('[^0-9]'), '');
    debugPrint("timeValue ===> $timeValue");
    if (timeValue == "30") {
      min = timeValue.substring(0, 2);
      debugPrint("min ===> $min");
    } else {
      hr = timeValue.substring(0, 2);
      debugPrint("hr ===> $hr");
      min = timeValue.substring(2, 4);
      debugPrint("min ===> $min");
    }

    String? usageTimeValue =
        widget.usageTimeSelectedValue!.replaceAll(RegExp('[^0-9]'), '');
    debugPrint("usageTimeValue ===> $usageTimeValue");
    String ushr = usageTimeValue.substring(0, 2);
    debugPrint("hr ===> $ushr");
    String usmin = usageTimeValue.substring(2, 4);
    debugPrint("min ===> $usmin");

    int newHr = int.parse(ushr) + int.parse(hr);
    int newMin = int.parse(usmin) + int.parse(min);
    if (newMin == 60) {
      newHr = newHr + 1;
      newMin = 0;
    }
    String latestTimeRange = setTime(newHr, newMin);
    debugPrint("latestTimeRange ===> $latestTimeRange");

    List<String>? ust = widget.usageTimeList;
    var firstIndex = ust?.indexOf(widget.usageTimeSelectedValue.toString());
    debugPrint("firstIndex =============> $firstIndex");
    var secondIndex;

    if (ust!.contains(latestTimeRange)) {
      secondIndex = ust.indexOf(latestTimeRange.toString());
      debugPrint("secondIndex =============> $secondIndex");
    } else {
      secondIndex = ust.indexOf(widget.usageTimeList!.last.toString());
      debugPrint("secondIndex =============> $secondIndex");
    }

    var getRange = ust.getRange(firstIndex!, secondIndex! + 1).join(",");
    List<String> rangeList = getRange!.split(",");
    debugPrint("rangeList =============> $rangeList");

    if (rangeList.length > 1) {
      debugPrint("rangeList not empty ============= ");

      for (int i = 0; i < rangeList.length; i++) {
        if (rangeList.length - 1 != i) {
          selectedTimeRangList.add('${rangeList[i]}-${rangeList[i + 1]}');
        }
      }
    } else {
      selectedTimeRangList
          .add('${widget.usageTimeSelectedValue}-$latestTimeRange');
    }
    debugPrint("selectedTimeRangList =============> $selectedTimeRangList");
  }

  String setTime(int newHr, int newMin) {
    if (newHr < 10 && newMin == 0) {
      return '0$newHr:0$newMin';
    } else if (newHr < 10) {
      return '0$newHr:$newMin';
    } else if (newMin == 0) {
      return '$newHr:0$newMin';
    } else {
      return '$newHr:$newMin';
    }
    // newMin == 0 ? '$newHr:0$newMin' : '$newHr:$newMin';
  }

  setItemWidth(int index) {
    if (widget.viewSeatSelectionListItem?[index].slotRange.toString() != "" &&
        widget.viewSeatSelectionListItem![index].seat == 0) {
      return 90.0;
    } else {
      if (widget.viewSeatSelectionListItem![index].seat! > 0 &&
          widget.viewSeatSelectionListItem?[index].slotRange.toString() == "") {
        return 40.0;
      } else if (widget.viewSeatSelectionListItem![index].seat! == 0 &&
          widget.viewSeatSelectionListItem?[index].slotRange.toString() == "") {
        return 90.0;
      } else {
        return 40.0;
      }
    }
  }

  String setTextValueForSeatView(int index) {
    if (widget.selectedSeatListForView[index].seat == -1) {
      return "Seat ";
    } else {
      return widget.selectedSeatListForView[index].seat.toString();
    }
  }

  setItemWidthForSeatView(int index) {
    if (widget.selectedSeatListForView[index].seat == -1) {
      return 90.0;
    } else {
      return 40.0;
    }
  }

// List<String>? getLatestUsageTime() {
//   String firstItem = widget.usageTimeList!.first.toString();
//   String lastItem = widget.usageTimeList!.last.toString();
//   debugPrint("firstItem ===> $firstItem");
//   debugPrint("lastItem ===> $lastItem");
//   String? selectedUsageTime = widget.totalTimeSelectedValue;
//   debugPrint("selectedUsageTime ===> $selectedUsageTime");
//
//
//   String firstHr = firstItem.substring(0, 2);
//   debugPrint("hr ===> $firstHr");
//   String firstMin = firstItem.substring(3, 5);
//   debugPrint("min ===> $firstMin");
//
//
//   String lasthr = lastItem.substring(0, 2);
//   debugPrint("hr ===> $lasthr");
//   String lastmin = lastItem.substring(3, 5);
//   debugPrint("min ===> $lastmin");
//
//   String? timeValue = widget.totalTimeSelectedValue!.replaceAll(RegExp('[^0-9]'), '');
//   String selectedUsageHr = "";
//   String selectedUsageMin = "";
//   // debugPrint("timeValue ===> $timeValue");
//   if(timeValue == "30"){
//     selectedUsageMin = timeValue.substring(0, 2);
//     debugPrint("selectedUsageMin ===> $selectedUsageMin");
//   }
//   else{
//     selectedUsageHr = timeValue.substring(0, 2);
//     debugPrint("selectedUsageHr ===> $selectedUsageHr");
//     selectedUsageMin = timeValue.substring(2, 4);
//     debugPrint("selectedUsageMin ===> $selectedUsageMin");
//   }
//
//
//   int newHr = int.parse(selectedUsageHr) + int.parse(lasthr);
//   int newMin = int.parse(selectedUsageMin) + int.parse(lastmin);
//   if (newMin == 60) {
//     newHr = newHr + 1;
//     newMin = 0;
//   }
//   String finalLatestTimeRange = setTime(newHr, newMin);
//   debugPrint("Final latestTimeRange ===> $finalLatestTimeRange");
//
//   String finalLatestTimeHr = finalLatestTimeRange.substring(0, 2);
//   debugPrint("finalLatestTimeHr ===> $firstHr");
//   String finalLatestTimeMin = finalLatestTimeRange.substring(3, 5);
//   debugPrint("finalLatestTimeMin ===> $firstMin");
//
//
//
//
//   var startTime =  TimeOfDay(hour: int.parse(firstHr) , minute: int.parse(firstMin) );
//   var endTime =  TimeOfDay(hour: int.parse(finalLatestTimeHr), minute: int.parse(finalLatestTimeMin) );
//   // var interval = const Duration(minutes: 30);
//   var interval = 30;
//
//   // List<TimeOfDay> timeIntervals = [];
//   List<String> timeIntervals = [];
//
//   // for (var time = startTime; time < endTime; time = _addDuration(time, interval)) {
//   //   timeIntervals.add(time);
//   // }
//   //
//   // // Printing the list of time intervals
//   // for (var time in timeIntervals) {
//   //   print('${time.hour}:${time.minute.toString().padLeft(2, '0')}');
//   // }
//
//
//   // Initialize the current time to the start time
//   var currentTime = startTime;
//
//   // Loop through the time intervals and add them to the list as formatted strings
//   while (currentTime.hour < endTime.hour ||
//       (currentTime.hour == endTime.hour && currentTime.minute <= endTime.minute)) {
//     timeIntervals.add(formatTime(currentTime));
//
//     // Add the interval to the current time
//     currentTime = currentTime.replacing(
//       hour: currentTime.hour + (currentTime.minute + interval) ~/ 60,
//       minute: (currentTime.minute + interval) % 60,
//     );
//   }
//
//   debugPrint("timeIntervals length  =========================> ${timeIntervals.length}");
//   debugPrint("timeIntervals first ==========================> ${timeIntervals.first}");
//   debugPrint("timeIntervals last ===========================> ${timeIntervals.last}");
//   debugPrint("timeIntervals List ===========================> $timeIntervals");
//
//   return timeIntervals;
//
// }
//
// String formatTime(TimeOfDay time) {
//   final hour = time.hour.toString().padLeft(2, '0');
//   final minute = time.minute.toString().padLeft(2, '0');
//   return '$hour:$minute';
// }
//
// TimeOfDay _addDuration(TimeOfDay time, Duration duration) {
//   final minutes = time.hour * 60 + time.minute;
//   final newMinutes = minutes + duration.inMinutes;
//   final newHour = newMinutes ~/ 60;
//   final newMinute = newMinutes % 60;
//   return TimeOfDay(hour: newHour, minute: newMinute);
// }
}
