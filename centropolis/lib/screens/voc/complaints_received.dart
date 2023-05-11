import 'dart:io';

import 'package:centropolis/widgets/common_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class ComplaintsReceived extends StatefulWidget {
  const ComplaintsReceived({super.key});

  @override
  State<ComplaintsReceived> createState() => _ComplaintsReceivedState();
}

class _ComplaintsReceivedState extends State<ComplaintsReceived> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("complaintsReceived"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("applicantInformation"),
                  style: const TextStyle(
                      fontFamily: 'SemiBold',
                      fontSize: 16,
                      color: CustomColors.textColor8),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr("nameLounge"),
                      style: const TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 14,
                          color: CustomColors.textColorBlack2),
                    ),
                    const Text(
                      "Hong Gil Dong",
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColorBlack2),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: CustomColors.backgroundColor2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr("tenantCompanyLounge"),
                      style: const TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 14,
                          color: CustomColors.textColorBlack2),
                    ),
                    const Text(
                      "CBRE",
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColorBlack2),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: CustomColors.backgroundColor,
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("enterComplaintDetails"),
                  style: const TextStyle(
                      fontFamily: 'SemiBold',
                      fontSize: 16,
                      color: CustomColors.textColor8),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  tr("typeOfComplaint"),
                  style: const TextStyle(
                      fontFamily: 'SemiBold',
                      fontSize: 14,
                      color: CustomColors.textColor8),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
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
                      hintText: "Construct",
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
                  onTap: () {},
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(tr("title"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8)),
                const SizedBox(
                  height: 8,
                ),
                TextField(
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
                    hintText: tr("titleHint"),
                    hintStyle: const TextStyle(
                      color: CustomColors.textColor3,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                  ),
                  style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 14,
                    fontFamily: 'Regular',
                  ),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(tr("detail"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.dividerGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  height: 288,
                  child: SingleChildScrollView(
                    child: TextField(
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintMaxLines: 5,
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        hintText: tr('detailHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.textColorBlack2,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(tr("attachment"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8)),
                if (imageFileList != null && imageFileList!.isNotEmpty)
                  Container(
                    height: 110,
                    margin: const EdgeInsets.only(top: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: imageFileList!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 110,
                          width: 110,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: CustomColors.dividerGreyColor)),
                          child: Stack(
                            children: [
                              Image.file(
                                File(imageFileList![index].path),
                                fit: BoxFit.fill,
                                width: 110,
                                height: 110,
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageFileList!.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: CustomColors.textColor3,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 4),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: CustomColors.whiteColor,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    selectImages();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomColors.dividerGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tr("photo"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.buttonBackgroundColor)),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.add,
                          color: CustomColors.buttonBackgroundColor,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(tr("photoNote"),
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColor3)),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: CustomColors.backgroundColor,
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 32),
              child: CommonButton(
                onCommonButtonTap: () {
                  showReservationModal();
                },
                buttonColor: CustomColors.buttonBackgroundColor,
                buttonName: tr("check"),
                isIconVisible: false,
              ),
            ),
          ),
        ],
      )),
    );
  }

  void showReservationModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("complaintsReceivedCompleted"),
            description:
                "Complaints have been submitted.After checking the manager, we will respond by e-mail or phone.",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void selectImages() async {
    final List<XFile> selectedImages =
        await imagePicker.pickMultiImage(maxHeight: 670, maxWidth: 670);
    if (selectedImages.isNotEmpty) {
      if (selectedImages.length <= 5) {
        imageFileList!.addAll(selectedImages);
      } else {
        showCustomToast(
            fToast, context, "Maximum 5 images allowed at a time", "");
      }
    }
    setState(() {});
  }
}
