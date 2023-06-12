import 'package:centropolis/models/view_seat_selection_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/common_button.dart';
import 'conference_reservation.dart';

class ViewSeatSelectionScreen extends StatefulWidget {
  final List<ViewSeatSelectionModel>? viewSeatSelectionListItem;
  final List<dynamic> timeSlotList;
  final List<dynamic> selectedSeatList;
  final String? usageTimeSelectedValue;
  final String? selectedSeatsValue;

  const ViewSeatSelectionScreen(
      this.viewSeatSelectionListItem,
      this.timeSlotList,
      this.selectedSeatList,
      this.usageTimeSelectedValue,
      this.selectedSeatsValue,
      {super.key});

  @override
  State<ViewSeatSelectionScreen> createState() =>
      _ViewSeatSelectionScreenState();
}

class _ViewSeatSelectionScreenState extends State<ViewSeatSelectionScreen> {
  bool selected = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint("Time slot list  ====> ${widget.timeSlotList}");
    debugPrint("Time list length ====> ${widget.timeSlotList.length}");
    debugPrint("usageTimeSelectedValue ====> ${widget.usageTimeSelectedValue}");
    debugPrint("selectedSeatsValue ====> ${widget.selectedSeatsValue}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
              color: CustomColors.backgroundColor,
              margin: const EdgeInsets.only(top: 40),
              padding:
              const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.timeSlotList.length,
                    childAspectRatio: 1,

                    // mainAxisExtent: 55,
                    mainAxisExtent: 205,
                  ),
                  itemCount: widget.viewSeatSelectionListItem?.length,
                  itemBuilder: (BuildContext ctx, index) {



                    return Container(
                      width: 40,
                      height: 34,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      margin: const EdgeInsets.only(right: 12, bottom: 12),
                      decoration: BoxDecoration(
                        color: setBackgroundColor(
                            widget.viewSeatSelectionListItem?[index]
                                .available,
                            widget.viewSeatSelectionListItem?[index].slot
                                .toString(),
                            widget.viewSeatSelectionListItem?[index].seat
                                .toString()),
                        border: Border.all(
                            color: setBorderColor(
                                widget.viewSeatSelectionListItem?[index]
                                    .available,
                                widget
                                    .viewSeatSelectionListItem?[index].slot
                                    .toString(),
                                widget
                                    .viewSeatSelectionListItem?[index].seat
                                    .toString()),
                            width: 1.0),
                      ),
                      child: Center(
                        child: Text(
                          setTextValue(index),


                            // widget.viewSeatSelectionListItem?[index].slot == "" ?
                            // '${widget.viewSeatSelectionListItem?[index].seat.toString()}'
                          // : 'seat -${widget.viewSeatSelectionListItem?[index].seat.toString() ?? ""} & time - ${widget.viewSeatSelectionListItem?[index].slot.toString() ?? ""}',
                          style: const TextStyle(
                            fontSize: 14,
                            // color: widget.viewSeatSelectionListItem?[index].available == false
                            //     ? CustomColors.textColor3 : CustomColors.whiteColor,
                            color: CustomColors.blackColor,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                    );
                  }),






              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //      Container(
              //         width: 100,
              //         color: Colors.yellow,
              //         child: Flexible(
              //           child: ListView.builder(
              //           physics: const NeverScrollableScrollPhysics(),
              //           scrollDirection: Axis.vertical,
              //           shrinkWrap: true,
              //           itemCount: widget.timeSlotList.length,
              //           itemBuilder: (BuildContext ctxt, int index) {
              //             return Container(
              //                 color: CustomColors.baseColor,
              //                 height: 27,
              //                 margin: const EdgeInsets.only(top: 5,bottom: 5),
              //                 child: Align(
              //                   alignment: Alignment.center,
              //                   child: Text(
              //                     widget.timeSlotList[index].toString(),
              //                     style: const TextStyle(
              //                         fontFamily: 'Regular',
              //                         fontSize: 14,
              //                         color: CustomColors.textColorBlack2),
              //                   ),
              //                 )
              //
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //
              //
              //
              //
              //     Flexible(
              //       child: GridView.builder(
              //           scrollDirection: Axis.horizontal,
              //           shrinkWrap: true,
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: widget.timeSlotList.length,
              //             childAspectRatio: 1,
              //
              //             // mainAxisExtent: 55,
              //             mainAxisExtent: 205,
              //           ),
              //           itemCount: widget.viewSeatSelectionListItem?.length,
              //           itemBuilder: (BuildContext ctx, index) {
              //             return Container(
              //               width: 40,
              //               height: 34,
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 10, vertical: 6),
              //               margin: const EdgeInsets.only(right: 12, bottom: 12),
              //               decoration: BoxDecoration(
              //                 color: setBackgroundColor(
              //                     widget.viewSeatSelectionListItem?[index]
              //                         .available,
              //                     widget.viewSeatSelectionListItem?[index].slot
              //                         .toString(),
              //                     widget.viewSeatSelectionListItem?[index].seat
              //                         .toString()),
              //                 border: Border.all(
              //                     color: setBorderColor(
              //                         widget.viewSeatSelectionListItem?[index]
              //                             .available,
              //                         widget
              //                             .viewSeatSelectionListItem?[index].slot
              //                             .toString(),
              //                         widget
              //                             .viewSeatSelectionListItem?[index].seat
              //                             .toString()),
              //                     width: 1.0),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   'seat -${widget.viewSeatSelectionListItem?[index].seat.toString() ?? ""} & time - ${widget.viewSeatSelectionListItem?[index].slot.toString() ?? ""}',
              //                   style: const TextStyle(
              //                     fontSize: 14,
              //                     // color: widget.viewSeatSelectionListItem?[index].available == false
              //                     //     ? CustomColors.textColor3 : CustomColors.whiteColor,
              //                     color: CustomColors.blackColor,
              //                     fontFamily: 'Regular',
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }),
              //     )
              //   ],
              // )



        ),
        );
  }

  setBackgroundColor(bool? availableStatus, String? slot, String? seat) {
    // debugPrint("slot ====> $slot");
    // debugPrint("seat ====> $seat");

    if (availableStatus == false) {
      return CustomColors.borderColor;
    } else {
      if (widget.usageTimeSelectedValue == slot && widget.selectedSeatsValue == seat) {
        return CustomColors.textColor9;
      }
      else if(slot == ""){
        return CustomColors.backgroundColor;
      }
      else {
        return CustomColors.whiteColor;
      }
    }
  }

  setBorderColor(bool? availableStatus, String? slot, String? seat) {
    if (availableStatus == false) {
      return CustomColors.borderColor;
    } else {
      if (widget.usageTimeSelectedValue == slot &&
          widget.selectedSeatsValue == seat) {
        return CustomColors.textColor9;
      }
      else if(slot == ""){
        return CustomColors.backgroundColor;
      }
      else {
        return CustomColors.textColor9;
      }
    }
  }

  String setTextValue(int index) {
    if(widget.viewSeatSelectionListItem?[index].slotRange.toString() != ""){
      return '${widget.viewSeatSelectionListItem?[index].slotRange.toString()}';
    }
    else{
      if(widget.viewSeatSelectionListItem![index].seat! > 0) {
        return '${widget.viewSeatSelectionListItem?[index].seat.toString()}';
      }
      else{
        return "Seat :";
      }
    }



  }
}
