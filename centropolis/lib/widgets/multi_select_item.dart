import 'package:centropolis/utils/custom_colors.dart';
import 'package:centropolis/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;
  final List<String>? alreadySelectedItems;
  const MultiSelect({Key? key, required this.items, this.alreadySelectedItems})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  List<String>? _selectedItems = [];
  List<String>? _previouslySelectedItems = [];
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _previouslySelectedItems = widget.alreadySelectedItems;
    _previouslySelectedItems?.forEach((element) {
      _selectedItems?.add(element);
    });
  }

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems?.add(itemValue);
      } else {
        _selectedItems?.remove(itemValue);
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
    } else {
      showCustomToast(fToast, context, tr("applicationFloorHint"), "");
    }
  }

  void _clearAll() {
    setState(() {
      _selectedItems?.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.only(top: 16, bottom: 16),
      actionsPadding: const EdgeInsets.only(left: 16, bottom: 16),
      contentPadding: const EdgeInsets.only(top: 10, left: 22, right: 16),
      title: Transform.translate(
        offset: const Offset(0, 0),
        child: Text(
          tr("applicationFloorLightOut"),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontFamily: 'SemiBold',
              fontSize: 16,
              color: CustomColors.textColor8),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => Container(
                    height: 40,
                    padding: EdgeInsets.zero,
                    child: Transform.translate(
                      offset: const Offset(-10, -10),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: _selectedItems?.contains(item),
                        activeColor: CustomColors.textColor9,
                        title: Transform.translate(
                            offset: const Offset(-15, 0),
                            child: Text(
                              item.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                  color: CustomColors.greyColor1),
                            )),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) => _itemChange(item, isChecked!),
                      ),
                    ),
                  ))
              .toList(),
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
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 50, right: 30),
          child: const Text(
            "",
            style: TextStyle(
              fontSize: 15,
              color: CustomColors.textColor9,
              fontFamily: 'SemiBold',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        InkWell(
          onTap: _cancel,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, right: 10),
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
            padding: const EdgeInsets.only(bottom: 10, right: 10),
            child: Text(
              tr('ok'),
              style: const TextStyle(
                fontSize: 15,
                color: CustomColors.textColor9,
                fontFamily: 'SemiBold',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
