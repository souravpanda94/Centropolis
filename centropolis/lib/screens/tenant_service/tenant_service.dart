import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';


class TenantServiceScreen extends StatefulWidget {
  const TenantServiceScreen({super.key});

  @override
  State<TenantServiceScreen> createState() => _TenantServiceScreenState();
}

class _TenantServiceScreenState extends State<TenantServiceScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              tr("tenantService"),
              style: const TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 14,
                  color: CustomColors.textColor8),
            )
        ));
  }



}