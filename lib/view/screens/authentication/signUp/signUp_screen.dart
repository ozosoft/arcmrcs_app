import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/view/components/custom-head-section-for-auth/auth_heading.dart';
import 'package:flutter_prime/view/screens/authentication/signUp/signUP-widgets/signUp_body_section.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        backgroundColor: MyColor.colorWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeadSection(height: Dimensions.space150,iconPosition: Dimensions.space60),
              SignUpBodySection(),
            ],
          ),
        ),
      ),
    );
  }
}
