import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';

class PlayDiffrentQuizes extends StatefulWidget {
  const PlayDiffrentQuizes({super.key});

  @override
  State<PlayDiffrentQuizes> createState() => _PlayDiffrentQuizesState();
}

class _PlayDiffrentQuizesState extends State<PlayDiffrentQuizes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.space18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimensions.space10),
          const Text(
            MyStrings.playDiffrentQuizs ,
            style: boldMediumLarge,
          ),
          const SizedBox(height: Dimensions.space10),
          Container(
            decoration: BoxDecoration(
                color: MyColor.colorWhite,
                borderRadius: BorderRadius.circular(Dimensions.space10)),
            height: 200,
            child: GridView.builder(
                // physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.red,
                    margin: EdgeInsets.all(10),
                    child: Text("Tfduicndck"),
                  );
                }),
          ),
        ],
      ),
    );
    ;
  }
}
