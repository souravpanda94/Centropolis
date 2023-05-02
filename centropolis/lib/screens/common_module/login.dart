import 'package:centropolis/widgets/bottom_navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import 'find_ID_password.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("login"), false, () {
              //onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Container(
        color: CustomColors.whiteColor,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/centropolis_logo.png',
                height: 69,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 32,
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
                  hintText: tr('id'),
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
              const SizedBox(
                height: 16,
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
                  hintText: tr('password'),
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
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                    width: 15,
                    child: Checkbox(
                      checkColor: CustomColors.whiteColor,
                      activeColor: CustomColors.buttonBackgroundColor,
                      side: const BorderSide(
                          color: CustomColors.greyColor, width: 1),
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                          if (_isChecked) {
                          } else {}
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Text(
                    tr("saveLoginInformation"),
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColorBlack2),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 32, bottom: 16),
                child: CommonButton(
                    onCommonButtonTap: () {
                      goToHomeScreen();
                    },
                    buttonColor: CustomColors.buttonBackgroundColor,
                    buttonName: tr("btnLogin"),
                    isIconVisible: false),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 16),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const FindIDPassword(page: 0),
                            ),
                          );
                        },
                        child: Text(
                          tr("findID"),
                          style: const TextStyle(
                              color: CustomColors.greyColor1,
                              fontFamily: 'Regular',
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 3),
                        child: const VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: CustomColors.borderColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const FindIDPassword(page: 1),
                            ),
                          );
                        },
                        child: Text(
                          tr("passwordReset"),
                          style: const TextStyle(
                              color: CustomColors.greyColor1,
                              fontFamily: 'Regular',
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 3),
                        child: const VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: CustomColors.borderColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          tr("signUp"),
                          style: const TextStyle(
                              color: CustomColors.greyColor1,
                              fontFamily: 'Regular',
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(0),
      ),
    );
  }
}
