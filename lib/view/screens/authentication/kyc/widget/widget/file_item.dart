import 'package:flutter/material.dart';
import 'package:quiz_lab/view/screens/authentication/kyc/widget/widget/choose_file_list_item.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/kyc_controller/kyc_controller.dart';
import 'package:quiz_lab/data/model/kyc/kyc_response_model.dart';

class ConfirmWithdrawFileItem extends StatefulWidget {
  final int index;

  const ConfirmWithdrawFileItem({Key? key, required this.index}) : super(key: key);

  @override
  State<ConfirmWithdrawFileItem> createState() => _ConfirmWithdrawFileItemState();
}

class _ConfirmWithdrawFileItemState extends State<ConfirmWithdrawFileItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(builder: (controller) {
      FormModel? model = controller.formList[widget.index];
      return InkWell(
          onTap: () {
            controller.pickFile(widget.index);
          },
          child: ChooseFileItem(fileName: model.selectedValue ?? MyStrings.chooseFile.tr));
    });
  }
}
