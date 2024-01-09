import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:centropolis/utils/firebase_analytics_events.dart';
import 'package:centropolis/widgets/common_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class ComplaintsReceived extends StatefulWidget {
  final String parentInquirId;

  const ComplaintsReceived({super.key, required this.parentInquirId});

  @override
  State<ComplaintsReceived> createState() => _ComplaintsReceivedState();
}

class _ComplaintsReceivedState extends State<ComplaintsReceived> {
  late String language, apiKey, companyId;
  String companyName = "";
  String name = "";
  String email = "";
  String mobile = "";
  late FToast fToast;
  bool isLoading = false;
  final ImagePicker imagePicker = ImagePicker();

  // List<XFile>? imageFileList = [];
  List<File>? imageFileList = [];
  String? complaintTypeTimeSelectedValue;
  List<dynamic> floorList = [];
  List<dynamic> complaintTypeList = [];
  String? currentSelectedFloor;
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  File? fileImage;
  String fileName = "";
  bool isLoadingRequired = false;

  @override
  void initState() {
    debugPrint("parentInquirId :: ${widget.parentInquirId}");
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    companyId = user.userData['company_id'].toString();
    internetCheckingForMethods();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: GestureDetector(
        onTap: () => hideKeyboard(),
        child: LoadingOverlay(
          opacity: 0.5,
          color: CustomColors.textColor4,
          progressIndicator: const CircularProgressIndicator(
            color: CustomColors.blackColor,
          ),
          isLoading: isLoading,
          child: Scaffold(
            backgroundColor: CustomColors.whiteColor,
            appBar: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: SafeArea(
                child: Container(
                  color: CustomColors.whiteColor,
                  child: CommonAppBar(tr("complaintsReceivedTitle"), false, () {
                    // onBackButtonPress(context);
                    Navigator.pop(context, isLoadingRequired);
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
                            tr("complaintReceivedName"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          Text(
                            // "Hong Gil Dong",
                            name,
                            style: const TextStyle(
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
                          Text(
                            // "CBRE",
                            companyName,
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          )
                        ],
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
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(tr("floor"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8)),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(" *",
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.headingColor)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      floorDropdownWidget(),
                      const SizedBox(
                        height: 16,
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
                      complaintTypeDropdownWidget(),
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
                      SizedBox(
                        height: 46,
                        child: TextField(
                          maxLines: 1,
                          inputFormatters: [RemoveEmojiInputFormatter()],
                          controller: titleController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.text,
                          showCursor: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 16,right: 16),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  color: CustomColors.dividerGreyColor,
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  color: CustomColors.dividerGreyColor,
                                  width: 1.0),
                            ),
                            hintText: tr("titleHint"),
                            hintStyle: const TextStyle(
                              height: 1.5,
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
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
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
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CustomColors.dividerGreyColor,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 258,
                        child: TextField(
                          inputFormatters: [RemoveEmojiInputFormatter()],
                          controller: detailController,
                          //maxLength: 500,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.multiline,
                          maxLines: 14,
                          decoration: InputDecoration(
                            counterText: "",
                            hintMaxLines: 500,
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
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
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
                          height: 107,
                          margin: const EdgeInsets.only(top: 8),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: imageFileList!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 108,
                                width: 108,
                                margin: const EdgeInsets.only(right: 10),
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: CustomColors.dividerGreyColor,
                                      width: 2.0),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(3.0),
                                      // child: Image.file(
                                      //   File(imageFileList![index].path),
                                      //   fit: BoxFit.fill,
                                      //   width: 108,
                                      //   height: 108,
                                      // ),
                                      child: Image(
                                          height: 108,
                                          width: 108,
                                          image: FileImage(
                                              File(imageFileList![index].path)),
                                          fit: BoxFit.cover),
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
                                              size: 14,
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
                          if (imageFileList != null &&
                              imageFileList!.length == 1) {
                            showErrorCommonModal(
                                context: context,
                                heading: tr("imageCountValidation"),
                                description: "",
                                buttonName: tr("check"));
                          } else {
                            // openImagePicker(ImageSource.gallery);
                            openFilePicker();
                          }
                        },
                        child: Container(
                          height: 46,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                                      color:
                                          CustomColors.buttonBackgroundColor)),
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
                  alignment: FractionalOffset.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 32),
                    child: CommonButton(
                      onCommonButtonTap: () {
                        //showReservationModal();
                        submitComplaintValidationCheck();
                      },
                      buttonColor: CustomColors.buttonBackgroundColor,
                      buttonName: tr("applyVOC"),
                      isIconVisible: false,
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  void showReservationModal(String heading, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: message,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context, isLoadingRequired);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  String getFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  openFilePicker() async {
    setDataInSharedPreference(ConstantsData.isClickedFilePicker, 'true');
    debugPrint(
        "openFilePicker ::: ${getDataFromSharedPreference(ConstantsData.isClickedFilePicker)}");

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['gif', 'jpg', 'jpeg', 'png', 'bmp'],
      );

      if (result != null) {
        List<File>? selectedImages =
            result.paths.map((path) => File(path!)).toList();

        if (selectedImages.length == 1) {
          final tempImage = File(selectedImages[0].path);

          String imageType = getFileExtension(selectedImages[0].path);
          debugPrint("image types ====> $imageType");

          if (imageType == "jpg" ||
              imageType == "jpeg" ||
              imageType == "png" ||
              imageType == "gif" ||
              imageType == "bmp") {
            var decodedImage =
                await decodeImageFromList(tempImage.readAsBytesSync());
            int imageWidth = decodedImage.width;
            int imageHeight = decodedImage.height;
            debugPrint(
                '----------------Image resolution ${decodedImage.width} X ${decodedImage.height}----------------');

            debugPrint(getFileSizeString(bytes: tempImage.lengthSync()));
            // final bytes = (await tempImage.readAsBytes()).lengthInBytes;
            final bytes = tempImage.readAsBytesSync().lengthInBytes;
            final kb = bytes / 1024;
            final mb = kb / 1024;
            debugPrint(
                "----------------Image size in bytes   $bytes---------------");
            debugPrint("----------------Image size in KB   $kb---------------");
            debugPrint("----------------Image size in MB   $mb---------------");

            if (mb > 15.0) {
              // showCustomToast(fToast, context, tr("imageSizeValidation"), "");
              showErrorCommonModal(
                  context: context,
                  heading: tr("imageSizeValidation"),
                  description: "",
                  buttonName: tr("check"));
            }
            // else if (imageWidth > 670 && imageHeight > 670) {
            //   showErrorCommonModal(context: context,
            //       heading :tr("imageDimensionValidation"),
            //       description: "",
            //       buttonName: tr("check"));
            // }
            // else if (imageWidth > 670) {
            //   // showCustomToast(
            //   //     fToast, context, tr("imageDimensionValidation"), "");
            //   showErrorCommonModal(context: context,
            //       heading :tr("imageDimensionValidation"),
            //       description: "",
            //       buttonName: tr("check"));
            // } else if (imageHeight > 670) {
            //   // showCustomToast(
            //   //     fToast, context, tr("imageDimensionValidation"), "");
            //   showErrorCommonModal(context: context,
            //       heading :tr("imageDimensionValidation"),
            //       description: "",
            //       buttonName: tr("check"));
            // }
            else {
              if (mounted) {
                setState(() {
                  fileImage = tempImage;
                  fileName =
                      fileImage!.path.split('/').last.replaceAll("image_", "");
                  imageFileList!.addAll(selectedImages);
                });
              }
            }
          } else {
            showErrorCommonModal(
                context: context,
                heading: tr("imageFormatNotSupported"),
                description: "",
                buttonName: tr("check"));
          }
        } else {
          showErrorCommonModal(
              context: context,
              heading: tr("imageCountValidation"),
              description: "",
              buttonName: tr("check"));
        }
      }
      setDataInSharedPreference(ConstantsData.isClickedFilePicker, 'false');
    } on PlatformException catch (e) {
      setDataInSharedPreference(ConstantsData.isClickedFilePicker, 'false');

      debugPrint("image pick null");
    }
  }

  // Future openImagePicker(ImageSource source) async {
  //   try {
  //     // final List<XFile> selectedImages = await ImagePicker().pickMultiImage(imageQuality: 70, maxHeight: 670, maxWidth: 670);
  //     final List<XFile> selectedImages =
  //         await ImagePicker().pickMultiImage(imageQuality: 70);
  //     if (selectedImages.isNotEmpty) {
  //       if (selectedImages.length == 1) {
  //         final tempImage = File(selectedImages[0].path);
  //
  //
  //         String imageType = getFileExtension(selectedImages[0].path);
  //         debugPrint("image types ====> $imageType");
  //
  //         if (imageType == "jpg" || imageType == "jpeg" || imageType == "png" || imageType == "gif" || imageType == "bmp") {
  //           var decodedImage =
  //           await decodeImageFromList(tempImage.readAsBytesSync());
  //           int imageWidth = decodedImage.width;
  //           int imageHeight = decodedImage.height;
  //           debugPrint(
  //               '----------------Image resolution ${decodedImage.width} X ${decodedImage.height}----------------');
  //
  //           debugPrint(getFileSizeString(bytes: tempImage.lengthSync()));
  //           // final bytes = (await tempImage.readAsBytes()).lengthInBytes;
  //           final bytes = tempImage.readAsBytesSync().lengthInBytes;
  //           final kb = bytes / 1024;
  //           final mb = kb / 1024;
  //           debugPrint(
  //               "----------------Image size in bytes   $bytes---------------");
  //           debugPrint("----------------Image size in KB   $kb---------------");
  //           debugPrint("----------------Image size in MB   $mb---------------");
  //
  //           if (mb > 15.0) {
  //             // showCustomToast(fToast, context, tr("imageSizeValidation"), "");
  //             showErrorCommonModal(context: context,
  //                 heading :tr("imageSizeValidation"),
  //                 description: "",
  //                 buttonName: tr("check"));
  //           }
  //           // else if (imageWidth > 670 && imageHeight > 670) {
  //           //   showErrorCommonModal(context: context,
  //           //       heading :tr("imageDimensionValidation"),
  //           //       description: "",
  //           //       buttonName: tr("check"));
  //           // }
  //           // else if (imageWidth > 670) {
  //           //   // showCustomToast(
  //           //   //     fToast, context, tr("imageDimensionValidation"), "");
  //           //   showErrorCommonModal(context: context,
  //           //       heading :tr("imageDimensionValidation"),
  //           //       description: "",
  //           //       buttonName: tr("check"));
  //           // } else if (imageHeight > 670) {
  //           //   // showCustomToast(
  //           //   //     fToast, context, tr("imageDimensionValidation"), "");
  //           //   showErrorCommonModal(context: context,
  //           //       heading :tr("imageDimensionValidation"),
  //           //       description: "",
  //           //       buttonName: tr("check"));
  //           // }
  //           else {
  //             setState(() {
  //               fileImage = tempImage;
  //               fileName = fileImage!.path.split('/').last.replaceAll("image_", "");
  //               imageFileList!.addAll(selectedImages);
  //             });
  //           }
  //
  //         }else{
  //           showErrorCommonModal(context: context,
  //               heading : tr("imageFormatNotSupported"),
  //               description: "",
  //               buttonName: tr("check"));
  //         }
  //
  //       }
  //       else {
  //         //showCustomToast(fToast, context, "Only 1 image can be uploaded", "");
  //          showErrorCommonModal(context: context,
  //                 heading :tr("imageCountValidation"),
  //                 description: "",
  //                 buttonName: tr("check"));
  //       }
  //     }
  //   } on PlatformException catch (e) {
  //     debugPrint("image pick null");
  //   }
  // }

  String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  floorDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          floorList.isNotEmpty
              ? floorList.first["floor"].toString().toUpperCase()
              : tr('floorHint'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: floorList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item["floor"],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 9),
                      child: Text(
                        item["floor"].toString().toUpperCase(),
                        style: const TextStyle(
                          color: CustomColors.blackColor,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    if (item != floorList.last)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: CustomColors.dividerGreyColor,
                      )
                  ],
                ),
              ),
            )
            .toList(),
        value: currentSelectedFloor,
        onChanged: (value) {
          setState(() {
            currentSelectedFloor = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding:
              EdgeInsets.only(bottom: currentSelectedFloor != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: currentSelectedFloor != null ? 0 : 13,
                bottom: currentSelectedFloor != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  void callLoadFloorListApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "company_id": companyId.toString().trim(),
    };

    debugPrint("Floor List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getFloorListUrl, body, language.toString(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Floor List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              floorList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  complaintTypeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          complaintTypeList.isNotEmpty
              ? complaintTypeList.first["text"]
              : "Construct",
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: complaintTypeList
            .map((item) => DropdownMenuItem<String>(
                  value: item["value"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["text"],
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      if (item != complaintTypeList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: complaintTypeTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            complaintTypeTimeSelectedValue = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding: EdgeInsets.only(
              bottom: complaintTypeTimeSelectedValue != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: complaintTypeTimeSelectedValue != null ? 0 : 13,
                bottom: complaintTypeTimeSelectedValue != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  void callLoadComplaintTypeListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getComplaintTypeListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              complaintTypeList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void submitComplaintValidationCheck() {
    if (currentSelectedFloor == null && floorList.isEmpty) {
      showErrorModal(tr("pleaseSelectFloor"));
    } else if (complaintTypeTimeSelectedValue == null &&
        complaintTypeList.isEmpty) {
      showErrorModal(tr("complaintTypeValidation"));
    } else if (titleController.text.trim().isEmpty) {
      showErrorModal(tr("complaintTitleValidation"));
    } else if (detailController.text.trim().isEmpty) {
      showErrorModal(tr("complaintDescriptionValidation"));
    } else {
      networkCheckForReservation();
    }
  }

  void showErrorModal(String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: message,
            description: "",
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

  void networkCheckForReservation() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callReservationApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callReservationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body;
    if (widget.parentInquirId.isNotEmpty) {
      body = {
        "email": email.trim(), //required
        "mobile": mobile.trim(), //required
        "description": detailController.text.toString().trim(), //required
        "name": name.toString().trim(), //required
        "type": complaintTypeTimeSelectedValue != null &&
                complaintTypeTimeSelectedValue.toString().isNotEmpty
            ? complaintTypeTimeSelectedValue.toString().trim()
            : complaintTypeList.first["value"].toString().trim(), //required
        "floor": currentSelectedFloor != null &&
                currentSelectedFloor.toString().isNotEmpty
            ? currentSelectedFloor.toString().trim()
            : floorList.first["floor"].toString().trim(), //required
        "title": titleController.text.toString().trim(),
        "parent_complaint_id":
            widget.parentInquirId.toString().trim(), //optional
        // "file_name" : fileName
      };
    } else {
      body = {
        "email": email.trim(), //required
        "mobile": mobile.trim(), //required
        "description": detailController.text.toString().trim(), //required
        "name": name.toString().trim(), //required
        "type": complaintTypeTimeSelectedValue != null &&
                complaintTypeTimeSelectedValue.toString().isNotEmpty
            ? complaintTypeTimeSelectedValue.toString().trim()
            : complaintTypeList.first["value"].toString().trim(), //required
        "floor": currentSelectedFloor != null &&
                currentSelectedFloor.toString().isNotEmpty
            ? currentSelectedFloor.toString().trim()
            : floorList.first["floor"].toString().trim(), //required
        "title": titleController.text.toString().trim(),
        // "file_name" : fileName
      };
    }

    debugPrint("Complaint received input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithMultipart(
        ApiEndPoint.saveComplaintUrl,
        body,
        fileImage,
        "file_name",
        null,
        apiKey.trim(),
        language.toString());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Complaint received  ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          hideKeyboard();
          showReservationModal(responseJson['title'].toString(),
              responseJson['message'].toString());

          titleController.clear();
          detailController.clear();

          if (widget.parentInquirId.isNotEmpty) {
            setFirebaseEventForInconvenienceApply(
                eventName: "cp_voc_reservation_inconvenience_add_inquiry",
                inconvenienceId: widget.parentInquirId.toString().trim());
          } else {
            setFirebaseEventForInconvenienceApply(
                eventName: "cp_apply_for_inconvenience",
                inconvenienceId: responseJson['inquiry_id'] ?? "");
          }
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          } else if (responseJson['error'] != null) {
            debugPrint("Server error response ${responseJson['error']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['error'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void callLoadPersonalInformationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Get personal info input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getPersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Get personal info ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          UserInfoModel userInfoModel = UserInfoModel.fromJson(responseJson);
          Provider.of<UserInfoProvider>(context, listen: false)
              .setItem(userInfoModel);

          setState(() {
            companyName = userInfoModel.companyName.toString();
            name = userInfoModel.name.toString();
            email = userInfoModel.email.toString();
            mobile = userInfoModel.mobile.toString();
            companyId = userInfoModel.companyId.toString();
          });
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void internetCheckingForMethods() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
      callLoadComplaintTypeListApi();
      callLoadFloorListApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }
}
