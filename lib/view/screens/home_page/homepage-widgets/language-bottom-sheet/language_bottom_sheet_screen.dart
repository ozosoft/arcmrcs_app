import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:flutter_prime/view/components/bottom-sheet/bottom_sheet_header_row.dart';

class LanguageBottomSheetScreen extends StatefulWidget {
  const LanguageBottomSheetScreen({super.key});

  @override
  State<LanguageBottomSheetScreen> createState() =>
      _LanguageBottomSheetScreenState();
}

class _LanguageBottomSheetScreenState extends State<LanguageBottomSheetScreen> {
  void _selectLanguage(String language) {
   
    print('Selected language: $language');
  }
  

   String selectedValue = 'Option 1';

   void handleRadioValueChanged(String? value) { // Update the parameter type to be nullable
    setState(() {
      selectedValue = value!;
      selectedValue = selectedValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 300,
      child: Column(
        children: [
        const  SizedBox(height: Dimensions.space10),
         const BottomSheetBar(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              MyStrings.selectACountry,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: MyStrings().languages.length,
              itemBuilder: (BuildContext context, int index) {
                final language = MyStrings().languages[index];
                return RadioListTile(
                activeColor: MyColor.primaryColor,
                  title: Text(language),
                  value: selectedValue,
                  groupValue: selectedValue,
                  onChanged: handleRadioValueChanged,
                  controlAffinity: ListTileControlAffinity
                      .trailing, 
                );
              },
            ),
          ),
          
        ],
      ),
    ));
  }
}
