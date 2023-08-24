import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/controller/play_diffrent_quizes/fun_n_learn/fun_n_learn_description.dart';
import 'package:flutter_prime/data/repo/play_diffrent_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_appbar.dart';
import 'package:get/get.dart';

class FunNlearnDescreiptionScreen extends StatefulWidget {
  const FunNlearnDescreiptionScreen({super.key});

  @override
  State<FunNlearnDescreiptionScreen> createState() => _FunNlearnDescreiptionScreenState();
}

class _FunNlearnDescreiptionScreenState extends State<FunNlearnDescreiptionScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));

    FunNLearnDescriptionController controller = Get.put(FunNLearnDescriptionController(funNLearnRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // controller.getFunAndLearndata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: MyStrings.details),
      
    );
  }
}
