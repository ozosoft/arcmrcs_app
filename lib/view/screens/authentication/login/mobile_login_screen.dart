import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/custom-head-section-for-auth/auth_heading.dart';
import 'package:flutter_prime/view/screens/authentication/login/widgets/login_body_section_screen.dart';

import 'widgets/mobile_login_body_section_screen.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeadSection(
                backbuttonPosition: Dimensions.space40,
                height: MediaQuery.of(context).size.height * .31,
                iconHasSize: true,
                iconPosition: MediaQuery.of(context).size.height * .12,
                hasBackButton: true,
                appbarTitle: MyStrings.signInByOtp,
              ),
              const MobileLoginBodySection(),
            ],
          ),
        ),
      ),
    );
  }
}
