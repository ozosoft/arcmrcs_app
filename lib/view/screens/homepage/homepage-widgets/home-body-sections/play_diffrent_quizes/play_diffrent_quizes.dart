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
            MyStrings.playDiffrentQuizs,
            style: boldMediumLarge,
          ),
          const SizedBox(height: Dimensions.space10),
          GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.blue,
                    margin: EdgeInsets.all(8.0),
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
        ],
      ),
    );
    ;
  }
}
