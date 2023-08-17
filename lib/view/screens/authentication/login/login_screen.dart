import 'package:flutter/material.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/custom-head-section-for-auth/auth_heading.dart';
import 'package:flutter_prime/view/screens/authentication/login/widgets/login_body_section_screen.dart';
import 'package:get/get.dart';

import '../../../../data/controller/auth/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {




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
               height: MediaQuery.of(context).size.height * .31,
               hasBackButton: false,
               iconHasSize: true,
               iconPosition: MediaQuery.of(context).size.height * .12,
             ),
             const LoginBodySection(),
           ],
         ),
       ),
        ),
    );
  }
}
