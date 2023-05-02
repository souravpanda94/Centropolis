import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';

class FindID extends StatefulWidget {
  const FindID({super.key});

  @override
  State<FindID> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindID> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: tr("email"),
                  style: const TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 14,
                      color: CustomColors.textColor8),
                  children: const [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                            color: CustomColors.heatingColor, fontSize: 12))
                  ]),
              maxLines: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              cursorColor: CustomColors.textColorBlack2,
              keyboardType: TextInputType.text,
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
                hintText: tr('emailHint'),
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
            ),
            Container(
              margin: const EdgeInsets.only(top: 32, bottom: 16),
              child: CommonButton(
                  onCommonButtonTap: () {
                    showMyModal();
                  },
                  buttonColor: CustomColors.buttonColor,
                  buttonName: tr("findID"),
                  isIconVisible: false),
            ),
          ],
        ),
      ),
    );
  }

  void showMyModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("identificationHasBeenCompleted"),
            description: "identificationHasBeenCompleted",
            buttonName: tr("confirm"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {},
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }
}
