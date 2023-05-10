import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class VisitReservationFilter extends StatefulWidget {
  const VisitReservationFilter({super.key});

  @override
  State<VisitReservationFilter> createState() => _VisitReservationFilterState();
}

class _VisitReservationFilterState extends State<VisitReservationFilter> {
  bool statusTapped = false;
  int showIndex = 0;

  List<dynamic> statusList = [
    "In Progress",
    "Visit Completed",
    "Rejected",
    "Approved"
  ];
  List<String> dateFilterList = [
    tr("week"),
    tr("month"),
    tr("year"),
    tr("directInput")
  ];
  TextEditingController statusController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String _range = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      // date range values
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy.MM.dd').format(args.value.startDate)} -'
            ' ${DateFormat('yyyy.MM.dd').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("filter"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        color: CustomColors.whiteColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
                text: tr("reservationStatus"),
                style: const TextStyle(
                    fontFamily: 'SemiBold',
                    fontSize: 14,
                    color: CustomColors.textColor8),
                children: const [
                  TextSpan(
                      text: ' *',
                      style: TextStyle(
                          color: CustomColors.headingColor, fontSize: 12))
                ]),
            maxLines: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: statusController,
            cursorColor: CustomColors.textColorBlack2,
            keyboardType: TextInputType.text,
            readOnly: true,
            showCursor: false,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                      color: CustomColors.dividerGreyColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                      color: CustomColors.dividerGreyColor, width: 1.0),
                ),
                hintText: "In progress",
                hintStyle: const TextStyle(
                  color: CustomColors.textColorBlack2,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(
                    "assets/images/ic_drop_down_arrow.svg",
                    width: 8,
                    height: 4,
                    color: CustomColors.textColorBlack2,
                  ),
                )),
            style: const TextStyle(
              color: CustomColors.blackColor,
              fontSize: 14,
              fontFamily: 'Regular',
            ),
            onTap: () {
              setState(() {
                statusTapped = true;
              });
            },
          ),
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                        text: tr("periodOfUse"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                        children: const [
                          TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: CustomColors.headingColor,
                                  fontSize: 12))
                        ]),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      color: CustomColors.backgroundColor,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: dateFilterList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              showIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: showIndex == index
                                    ? CustomColors.whiteColor
                                    : CustomColors.backgroundColor,
                                border: showIndex == index
                                    ? Border.all(
                                        color: CustomColors.textColorBlack2,
                                      )
                                    : null,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            child: Text(
                              dateFilterList[index],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: showIndex == index
                                      ? CustomColors.textColorBlack2
                                      : CustomColors.textColor3),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: dateController,
                    cursorColor: CustomColors.textColorBlack2,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    showCursor: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: "YYYY.MM.DD - YYYY.MM.DD",
                        hintStyle: const TextStyle(
                          color: CustomColors.textColorBlack2,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.asset(
                            "assets/images/ic_date.svg",
                            width: 8,
                            height: 4,
                            color: CustomColors.textColorBlack2,
                          ),
                        )),
                    style: const TextStyle(
                      color: CustomColors.blackColor,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                    onTap: () {
                      showIndex == 3
                          ? showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SfDateRangePicker(
                                    enablePastDates: false,
                                    selectionColor:
                                        CustomColors.buttonBackgroundColor,
                                    view: DateRangePickerView.month,
                                    todayHighlightColor:
                                        CustomColors.buttonBackgroundColor,
                                    minDate: DateTime.now(),
                                    showActionButtons: true,
                                    onSelectionChanged: _onSelectionChanged,
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    rangeSelectionColor: const Color.fromARGB(
                                        255, 245, 236, 231),
                                    startRangeSelectionColor:
                                        CustomColors.buttonBackgroundColor,
                                    endRangeSelectionColor:
                                        CustomColors.buttonBackgroundColor,
                                    monthCellStyle:
                                        const DateRangePickerMonthCellStyle(
                                            todayTextStyle: TextStyle(
                                                color: CustomColors
                                                    .buttonBackgroundColor)),
                                    // initialSelectedRange: PickerDateRange(
                                    //     DateTime.now()
                                    //         .subtract(const Duration(days: 0)),
                                    //     DateTime.now()
                                    //         .add(const Duration(days: 3))),
                                    onCancel: () {
                                      Navigator.pop(context);
                                    },
                                    onSubmit: (p0) {
                                      debugPrint(" onSubmit ::: $p0");

                                      setState(() {
                                        dateController.text = _range;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              })
                          : null;
                    },
                  ),
                ],
              ),
              if (statusTapped)
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    border: Border.all(
                      color: CustomColors.dividerGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(4, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                statusController.text = statusList[index];

                                setState(() {
                                  statusTapped = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  statusList[index],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              height: 1,
                              color: CustomColors.dividerGreyColor,
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ),
            ],
          )
        ]),
      )),
      bottomSheet: Container(
        color: CustomColors.whiteColor,
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 40, right: 16),
        child: CommonButton(
          onCommonButtonTap: () {},
          buttonColor: CustomColors.buttonBackgroundColor,
          buttonName: tr("check"),
          isIconVisible: false,
        ),
      ),
    );
  }
}
