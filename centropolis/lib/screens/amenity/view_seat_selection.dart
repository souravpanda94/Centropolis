import 'package:centropolis/models/view_seat_selection_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/common_button.dart';
import 'conference_reservation.dart';

class ViewSeatSelectionScreen extends StatefulWidget {
  final List<ViewSeatSelectionModel>? viewSeatSelectionListItem;
  final int timeListLength;

  const ViewSeatSelectionScreen(this.viewSeatSelectionListItem, this.timeListLength, {super.key});

  @override
  State<ViewSeatSelectionScreen> createState() => _ViewSeatSelectionScreenState();
}

class _ViewSeatSelectionScreenState extends State<ViewSeatSelectionScreen> {
  bool selected = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint("Time list length ====> ${widget.timeListLength}");
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       // height: 223,
       color: CustomColors.backgroundColor,
       margin: const EdgeInsets.only(top: 40),
       padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
       child: GridView.builder(
           scrollDirection: Axis.horizontal,
           shrinkWrap: true,
           gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: widget.timeListLength-1,
             childAspectRatio: 1,

             // mainAxisExtent: 55,
             mainAxisExtent: 205,
           ),
           itemCount: widget.viewSeatSelectionListItem?.length,
           itemBuilder: (BuildContext ctx, index) {
             return Container(
                   width: 40,
                   height: 34,
                   padding:
                   const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                   margin: const EdgeInsets.only(right: 12, bottom: 12),
                   decoration: BoxDecoration(
                     color: widget.viewSeatSelectionListItem?[index].available == false
                         ? CustomColors.borderColor : CustomColors.whiteColor,
                     border: Border.all(
                         color: widget.viewSeatSelectionListItem?[index].available == false
                             ? CustomColors.borderColor
                             : CustomColors.textColor9,
                         width: 1.0),
                   ),
                   child: Center(
                     child: Text(
                       'seat -${widget.viewSeatSelectionListItem?[index].seat.toString() ?? ""} & time - ${widget.viewSeatSelectionListItem?[index].slot.toString() ?? ""}',
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
     )
   );


  }

}