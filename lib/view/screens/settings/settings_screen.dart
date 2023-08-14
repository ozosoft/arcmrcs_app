


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/divider/custom_divider.dart';




class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _sound = false;
  bool _vibration = false;
  bool _themes = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomCategoryAppBar(title: MyStrings.settings,),
      body: Card(
        margin:const EdgeInsets.all(Dimensions.space15),
        elevation: 0,
        child: Column(
          children: [
            ListTile(
            
              title:const Text(MyStrings.sound),
              
              trailing: CupertinoSwitch(
                 
                activeColor: MyColor.primaryColor,
                    value: _sound,
                    onChanged: (value) {
                      setState(() {
                        _sound = value;
                      });
                    },
                  ),
            ),
           const Divider(color: MyColor.colorBlack,endIndent: Dimensions.space15,indent: Dimensions.space15 ,thickness: .1),
            ListTile(
            
              title:const Text(MyStrings.vibration),
              
              trailing: CupertinoSwitch(
                 
                activeColor: MyColor.primaryColor,
                    value: _vibration,
                    onChanged: (value) {
                      setState(() {
                        _vibration = value;
                      });
                    },
                  ),
            ),
               const Divider(color: MyColor.colorBlack,endIndent: Dimensions.space15,indent: Dimensions.space15 ,thickness: .3),
            ListTile(
            
              title:const Text(MyStrings.themes),
              
              trailing: CupertinoSwitch(
                 
                activeColor: MyColor.primaryColor,
                    value: _themes,
                    onChanged: (value) {
                      setState(() {
                        _themes = value;
                      });
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}