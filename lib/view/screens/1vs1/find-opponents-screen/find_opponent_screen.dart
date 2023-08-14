import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';

import '../../../components/app-bar/custom_category_appBar.dart';
import 'find-opponets-widgets/find_oppnent_body_section.dart';



class FindOpponenetScreen extends StatelessWidget {
  const FindOpponenetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       appBar: CustomCategoryAppBar(title: MyStrings.letsPlay),
       body: SingleChildScrollView(child: FindOpponentsBodySection()),
    );
    
  }
}

