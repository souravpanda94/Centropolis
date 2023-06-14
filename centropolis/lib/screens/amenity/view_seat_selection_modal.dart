import 'dart:convert';

import 'package:centropolis/models/view_seat_selection_model.dart';
import 'package:centropolis/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/app_bar_for_dialog.dart';
import '../../widgets/common_button.dart';
import 'conference_reservation.dart';

class ViewSeatSelectionModalScreen extends StatefulWidget {
  final List<ViewSeatSelectionModel>? viewSeatSelectionListItem;
  final List<dynamic> timeSlotList;
  final List<dynamic> selectedSeatList;
  final String? usageTimeSelectedValue;
  final String? selectedSeatsValue;
  final String? totalTimeSelectedValue;
  final List<String>? usageTimeList;

  const ViewSeatSelectionModalScreen(
      this.viewSeatSelectionListItem,
      this.timeSlotList,
      this.selectedSeatList,
      this.usageTimeSelectedValue,
      this.selectedSeatsValue,
      this.totalTimeSelectedValue,
      this.usageTimeList,
      {super.key});

  @override
  State<ViewSeatSelectionModalScreen> createState() =>
      _ViewSeatSelectionModalScreenState();
}

class _ViewSeatSelectionModalScreenState extends State<ViewSeatSelectionModalScreen> {
  bool selected = false;
  int selectedIndex = 0;
  double mainAxisExtentValue = 55.0;
  List<String> selectedTimeRangList = [];

  @override
  void initState() {
    super.initState();
    debugPrint("Time slot list  ====> ${widget.timeSlotList}");
    debugPrint("Time list length ====> ${widget.timeSlotList.length}");
    debugPrint("usageTimeSelectedValue ====> ${widget.usageTimeSelectedValue}");
    debugPrint("selectedSeatsValue ====> ${widget.selectedSeatsValue}");
    debugPrint("totalTimeSelectedValue ====> ${widget.totalTimeSelectedValue}");
    debugPrint("usageTimeList ====> ${widget.usageTimeList}");
    setSelectionTimeRange();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height / 1.1;

    return Scaffold(
        backgroundColor: CustomColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: AppBarForDialog(tr("viewSeatSelection"), () {
                onBackButtonPress(context);
              }),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: CustomColors.whiteColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("seatSelection"),
                        style: const TextStyle(
                          fontSize: 16,
                          color: CustomColors.textColor8,
                          fontFamily: 'SemiBold',
                        ),
                      ),
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
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tr("sleepingRoom(Female)"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.purple,
                      height: height,
                      margin: const EdgeInsets.only(top: 20),
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: widget.timeSlotList.length,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 10,

                                  mainAxisExtent: 50,
                                  // mainAxisExtent: 90,
                                // mainAxisExtent: mainAxisExtentValue,

                                  ),
                          itemCount: widget.viewSeatSelectionListItem?.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              width: 50,
                              height: 34,
                              decoration: BoxDecoration(
                                color: setBackgroundColor(
                                    widget.viewSeatSelectionListItem?[index].available,
                                    widget.viewSeatSelectionListItem?[index].slot.toString(),
                                    widget.viewSeatSelectionListItem?[index].slotRange.toString(),
                                    widget.viewSeatSelectionListItem?[index].seat.toString()),
                                border: Border.all(
                                    color: setBorderColor(
                                        widget.viewSeatSelectionListItem?[index].available,
                                        widget.viewSeatSelectionListItem?[index].slot.toString(),
                                        widget.viewSeatSelectionListItem?[index].slotRange.toString(),
                                        widget.viewSeatSelectionListItem?[index].seat.toString()),
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
                          }),
                    )
                  ]),
                )
              ],
            ),
          ),
        ));

    // return AlertDialog(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(4),
    //     ),
    //     insetPadding: const EdgeInsets.only(left: 18.0, right: 18.0),
    //     contentPadding: const EdgeInsets.only(
    //         top: 20,
    //         bottom: 30.0,
    //         left: 20.0,
    //         right: 20.0),
    //     scrollable: true,
    //     content: SizedBox(
    //         width: width,
    //         height: height,
    //         child: Column(
    //             // mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Container(
    //                 color: CustomColors.whiteColor,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       tr("seatSelection"),
    //                       style: const TextStyle(
    //                         fontSize: 16,
    //                         color: CustomColors.textColor8,
    //                         fontFamily: 'SemiBold',
    //                       ),
    //                     ),
    //                     Row(
    //                       children: [
    //                         Row(
    //                           children: [
    //                             const Icon(
    //                               Icons.square,
    //                               size: 15,
    //                               color: CustomColors.textColor9,
    //                             ),
    //                             const SizedBox(
    //                               width: 4,
    //                             ),
    //                             Text(
    //                               tr("select"),
    //                               style: const TextStyle(
    //                                 fontSize: 12,
    //                                 color: CustomColors.greyColor1,
    //                                 fontFamily: 'Regular',
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                         const SizedBox(
    //                           width: 8,
    //                         ),
    //                         Row(
    //                           children: [
    //                             const Icon(
    //                               Icons.square_outlined,
    //                               size: 15,
    //                               color: CustomColors.textColor9,
    //                             ),
    //                             const SizedBox(
    //                               width: 4,
    //                             ),
    //                             Text(
    //                               tr("selectable"),
    //                               style: const TextStyle(
    //                                 fontSize: 12,
    //                                 color: CustomColors.greyColor1,
    //                                 fontFamily: 'Regular',
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                         const SizedBox(
    //                           width: 8,
    //                         ),
    //                         Row(
    //                           children: [
    //                             const Icon(
    //                               Icons.square,
    //                               size: 15,
    //                               color: CustomColors.borderColor,
    //                             ),
    //                             const SizedBox(
    //                               width: 4,
    //                             ),
    //                             Text(
    //                               tr("closed"),
    //                               style: const TextStyle(
    //                                 fontSize: 12,
    //                                 color: CustomColors.greyColor1,
    //                                 fontFamily: 'Regular',
    //                               ),
    //                             )
    //                           ],
    //                         )
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Expanded(
    //                   child: Container(
    //                     margin: const EdgeInsets.only(top: 10),
    //                     color: CustomColors.backgroundColor,
    //                     child: Column(children: [
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 15, left: 10),
    //                         child: Align(
    //                           alignment: Alignment.centerLeft,
    //                           child: Text(
    //                             tr("sleepingRoom(Female)"),
    //                             style: const TextStyle(
    //                                 fontFamily: 'SemiBold',
    //                                 fontSize: 14,
    //                                 color: CustomColors.textColorBlack2),
    //                           ),
    //                         ),
    //                       ),
    //                       Flexible(
    //                           child: Container(
    //                             color: Colors.purple,
    //                             margin: const EdgeInsets.only(top: 20),
    //                             child: GridView.builder(
    //                                 scrollDirection: Axis.horizontal,
    //                                 shrinkWrap: true,
    //                                 gridDelegate:
    //                                 SliverGridDelegateWithFixedCrossAxisCount(
    //                                   crossAxisCount: widget.timeSlotList.length,
    //                                   childAspectRatio: 1,
    //
    //                                   // mainAxisExtent: 55,
    //                                   mainAxisExtent: 205,
    //                                 ),
    //                                 itemCount: widget.viewSeatSelectionListItem?.length,
    //                                 itemBuilder: (BuildContext ctx, index) {
    //                                   return Container(
    //                                     width: 40,
    //                                     height: 34,
    //                                     padding: const EdgeInsets.symmetric(
    //                                         horizontal: 10, vertical: 6),
    //                                     margin:
    //                                     const EdgeInsets.only(right: 12, bottom: 12),
    //                                     decoration: BoxDecoration(
    //                                       color: setBackgroundColor(
    //                                           widget.viewSeatSelectionListItem?[index]
    //                                               .available,
    //                                           widget
    //                                               .viewSeatSelectionListItem?[index].slot
    //                                               .toString(),
    //                                           widget
    //                                               .viewSeatSelectionListItem?[index].seat
    //                                               .toString()),
    //                                       border: Border.all(
    //                                           color: setBorderColor(
    //                                               widget.viewSeatSelectionListItem?[index]
    //                                                   .available,
    //                                               widget.viewSeatSelectionListItem?[index]
    //                                                   .slot
    //                                                   .toString(),
    //                                               widget.viewSeatSelectionListItem?[index]
    //                                                   .seat
    //                                                   .toString()),
    //                                           width: 1.0),
    //                                     ),
    //                                     child: Center(
    //                                       child: Text(
    //                                         setTextValue(index),
    //
    //                                         // widget.viewSeatSelectionListItem?[index].slot == "" ?
    //                                         // '${widget.viewSeatSelectionListItem?[index].seat.toString()}'
    //                                         // : 'seat -${widget.viewSeatSelectionListItem?[index].seat.toString() ?? ""} & time - ${widget.viewSeatSelectionListItem?[index].slot.toString() ?? ""}',
    //                                         style: const TextStyle(
    //                                           fontSize: 14,
    //                                           // color: widget.viewSeatSelectionListItem?[index].available == false
    //                                           //     ? CustomColors.textColor3 : CustomColors.whiteColor,
    //                                           color: CustomColors.blackColor,
    //                                           fontFamily: 'Regular',
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   );
    //                                 }),
    //                           )),
    //                     ]),
    //                   ))
    //             ],
    //           ),
    //
    //
    //
    //
    //     ));

  }

  setBackgroundColor(bool? availableStatus, String? slot,String? slotRange, String? seat) {
    if (availableStatus == false) {
      return CustomColors.borderColor;
    } else {
      // if (widget.usageTimeSelectedValue == slot && widget.selectedSeatsValue == seat) {
      if (widget.selectedSeatsValue == seat) {
        for(int i = 0; i< selectedTimeRangList.length ; i++){
          if(selectedTimeRangList[i] == slotRange){
            return CustomColors.textColor9;
          }
        }
      } else if (slot == "") {
        return CustomColors.backgroundColor;
      } else {
        return CustomColors.whiteColor;
      }
    }
  }

  setBorderColor(bool? availableStatus, String? slot,String? slotRange, String? seat) {
    if (availableStatus == false) {
      return CustomColors.borderColor;
    } else {
      if (widget.selectedSeatsValue == seat) {
        for(int i = 0; i< selectedTimeRangList.length ; i++){
          if(selectedTimeRangList[i] == slotRange){
            return CustomColors.textColor9;
          }
        }
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
        return "Seat :";
      } else {
        return "";
      }
    }
  }

  setMainAxisExtent(int index) {
    if (widget.viewSeatSelectionListItem?[index].slotRange.toString() != "" &&
        widget.viewSeatSelectionListItem![index].seat == 0) {
      // return 205;
      setState(() {
        mainAxisExtentValue = 120.0;
      });
    } else {
      if (widget.viewSeatSelectionListItem![index].seat! > 0 &&
          widget.viewSeatSelectionListItem?[index].slotRange.toString() == "") {
        setState(() {
          mainAxisExtentValue = 55.0;
        });
      } else if (widget.viewSeatSelectionListItem![index].seat! == 0 &&
          widget.viewSeatSelectionListItem?[index].slotRange.toString() == "") {
        setState(() {
          mainAxisExtentValue = 120.0;
        });
      } else {
        setState(() {
          mainAxisExtentValue = 55.0;
        });
      }
    }
  }

  void setSelectionTimeRange() {
    String? timeValue = widget.totalTimeSelectedValue!.replaceAll(RegExp('[^0-9]'), '');
    debugPrint("timeValue ===> $timeValue");
    String hr = timeValue.substring(0,2);
    debugPrint("hr ===> $hr");
    String min = timeValue.substring(2,4);
    debugPrint("min ===> $min");


    String? usageTimeValue = widget.usageTimeSelectedValue!.replaceAll(RegExp('[^0-9]'), '');
    debugPrint("usageTimeValue ===> $usageTimeValue");
    String ushr = usageTimeValue.substring(0,2);
    debugPrint("hr ===> $ushr");
    String usmin = usageTimeValue.substring(2,4);
    debugPrint("min ===> $usmin");


    int newHr = int.parse(ushr) + int.parse(hr);
    int newMin = int.parse(usmin) + int.parse(min);
    if(newMin == 60){
      newHr = newHr + 1;
      newMin = 0;
    }
    String latestTimeRange = newMin == 0 ? '$newHr:0$newMin' : '$newHr:$newMin';
    debugPrint("latestTimeRange ===> $latestTimeRange");


    List<String>? ust = widget.usageTimeList;
    var firstIndex = ust?.indexOf(widget.usageTimeSelectedValue.toString());
    var secondIndex = ust?.indexOf(latestTimeRange.toString());
    var getRange = ust?.getRange(firstIndex!, secondIndex!+1).join(",");
    List<String> rangeList = getRange!.split(",");
    debugPrint("rangeList =============> $rangeList");


    for (int i = 0; i < rangeList!.length; i++) {
      if (rangeList.length - 1 != i) {
        selectedTimeRangList.add('${rangeList[i]}-${rangeList[i + 1]}');
      }
    }
    debugPrint("selectedTimeRangList =============> $selectedTimeRangList");
  }

}
