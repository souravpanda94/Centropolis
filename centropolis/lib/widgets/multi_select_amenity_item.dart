import 'package:centropolis/utils/custom_colors.dart';
import 'package:centropolis/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MultiSelectAmenityEquipments extends StatefulWidget {
  final List<dynamic> items;
  final List<dynamic>? alreadySelectedItems;

  const MultiSelectAmenityEquipments(
      {Key? key, required this.items, this.alreadySelectedItems})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectAmenityEquipmentsState();
}

enum Services { request, noRequest }

class _MultiSelectAmenityEquipmentsState
    extends State<MultiSelectAmenityEquipments> {
  // this variable holds the selected items
  List<dynamic>? _selectedItems = [];
  List<dynamic>? _previouslySelectedItems = [];
  late FToast fToast;
  Services? services = Services.request;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _previouslySelectedItems = widget.alreadySelectedItems;
    _previouslySelectedItems?.forEach((element) {
      if (element["value"] != "") {
        _selectedItems?.add(element);
      } else {
        setState(() {
          services = Services.noRequest;
        });
      }
    });
  }

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected, dynamic item) {
    setState(() {
      if (isSelected) {
        _selectedItems?.add(item);
      } else {
        _selectedItems?.remove(item);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    if (_selectedItems!.isNotEmpty) {
      Navigator.pop(context, _selectedItems);
    } else if (services == Services.noRequest) {
      Navigator.pop(context, [
        {"value": "", "text": tr("noRequest")}
      ]);
    } else {
      //showCustomToast(fToast, context, tr("equipmentsHint"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("equipmentsHint"),
          description: "",
          buttonName: tr("check"));
    }
  }

  void _clearAll() {
    setState(() {
      _selectedItems?.clear();
    });
  }

  void changeRadioSelection(Services value) {
    setState(() {
      services = value;
      if (_selectedItems != null && value == Services.noRequest) {
        _selectedItems!.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      // actionsPadding: const EdgeInsets.only(left: 16, bottom: 16),
      insetPadding: const EdgeInsets.only(
          left: 18.0, right: 18.0, top: 20.0, bottom: 30.0),
      contentPadding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
      title: Transform.translate(
        offset: const Offset(-7, 0),
        child: Text(
          tr("equipments"),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontFamily: 'SemiBold',
              fontSize: 16,
              color: CustomColors.textColor8),
          textAlign: TextAlign.left,
        ),
      ),
      content: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  changeRadioSelection(Services.request);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio<Services>(
                          activeColor: CustomColors.buttonBackgroundColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: Services.request,
                          groupValue: services,
                          onChanged: (Services? value) {
                            changeRadioSelection(value!);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          tr("request"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              color: CustomColors.textColorBlack2,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListBody(
                children: widget.items
                    .map((item) => Container(
                          //height: 40,
                          padding: const EdgeInsets.only(left: 20),
                          child: Transform.translate(
                            offset: const Offset(-10, -5),
                            child: CheckboxListTile(
                              enabled:
                                  services == Services.request ? true : false,
                              side: const BorderSide(
                                  color: CustomColors.dividerGreyColor),
                              contentPadding: EdgeInsets.zero,
                              value: _selectedItems?.contains(item),
                              activeColor: CustomColors.textColor9,
                              title: Transform.translate(
                                  offset: const Offset(-15, 0),
                                  child: Text(
                                    item["text"].toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: services == Services.request
                                          ? CustomColors.greyColor1
                                          : CustomColors.dividerGreyColor,
                                      fontFamily: 'Regular',
                                    ),
                                  )),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (isChecked) =>
                                  _itemChange(item["text"], isChecked!, item),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              InkWell(
                onTap: () {
                  changeRadioSelection(Services.noRequest);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio<Services>(
                          activeColor: CustomColors.buttonBackgroundColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: Services.noRequest,
                          groupValue: services,
                          onChanged: (Services? value) {
                            changeRadioSelection(value!);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          tr("noRequest"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              color: CustomColors.textColorBlack2,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      actions: [
        InkWell(
            onTap: _clearAll,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: Text(
                tr('clearAll'),
                style: const TextStyle(
                  fontSize: 15,
                  color: CustomColors.textColor9,
                  fontFamily: 'SemiBold',
                ),
                textAlign: TextAlign.left,
              ),
            )),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        const Text(
          "",
          style: TextStyle(
            fontSize: 15,
            color: CustomColors.textColor9,
            fontFamily: 'SemiBold',
          ),
          textAlign: TextAlign.left,
        ),
        InkWell(
          onTap: _cancel,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, right: 8, left: 10),
            child: Text(tr('cancel'),
                style: const TextStyle(
                  fontSize: 15,
                  color: CustomColors.textColor9,
                  fontFamily: 'SemiBold',
                )),
          ),
        ),
        InkWell(
            onTap: _submit,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                tr('ok'),
                style: const TextStyle(
                  fontSize: 15,
                  color: CustomColors.textColor9,
                  fontFamily: 'SemiBold',
                ),
              ),
            )),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding:
          const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
    );
  }
}
