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

  const ViewSeatSelectionModalScreen(
      this.viewSeatSelectionListItem,
      this.timeSlotList,
      this.selectedSeatList,
      this.usageTimeSelectedValue,
      this.selectedSeatsValue,
      {super.key});

  @override
  State<ViewSeatSelectionModalScreen> createState() =>
      _ViewSeatSelectionModalScreenState();
}

class _ViewSeatSelectionModalScreenState
    extends State<ViewSeatSelectionModalScreen> {
  bool selected = false;
  int selectedIndex = 0;
  double mainAxisExtentValue = 55.0;

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
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 10, vertical: 6),
                              // margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: setBackgroundColor(
                                    widget.viewSeatSelectionListItem?[index]
                                        .available,
                                    widget
                                        .viewSeatSelectionListItem?[index].slot
                                        .toString(),
                                    widget
                                        .viewSeatSelectionListItem?[index].seat
                                        .toString()),
                                border: Border.all(
                                    color: setBorderColor(
                                        widget.viewSeatSelectionListItem?[index]
                                            .available,
                                        widget.viewSeatSelectionListItem?[index]
                                            .slot
                                            .toString(),
                                        widget.viewSeatSelectionListItem?[index]
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

  setBackgroundColor(bool? availableStatus, String? slot, String? seat) {
    // debugPrint("slot ====> $slot");
    // debugPrint("seat ====> $seat");

    if (availableStatus == false) {
      return CustomColors.borderColor;
    } else {
      if (widget.usageTimeSelectedValue == slot &&
          widget.selectedSeatsValue == seat) {
        return CustomColors.textColor9;
      } else if (slot == "") {
        return CustomColors.backgroundColor;
      } else {
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
}
