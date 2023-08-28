import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_appbar.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/components/will_pop_widget.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/result/widget/result_body.dart';
import 'package:get/get.dart';

class GessWordResultScreen extends StatefulWidget {
  const GessWordResultScreen({super.key});

  @override
  State<GessWordResultScreen> createState() => _GessWordResultScreenState();
}

class _GessWordResultScreenState extends State<GessWordResultScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.gessThewordCatagori,
      child: Scaffold(
          appBar: const CustomCategoryAppBar(
            title: MyStrings.quizResult,
         
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: Dimensions.screenPaddingHV,
              child: GetBuilder<GessThewordController>(builder: (controller) {
                return controller.isLoading ? const CustomLoader() : const GessResultBody();
              }),
            ),
          )),
    );
  }
}
