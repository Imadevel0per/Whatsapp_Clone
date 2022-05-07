import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyProgressBar extends StatelessWidget {


  MyProgressBar({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinearPercentIndicator(
        lineHeight: 5,
        percent: 1.0,
        progressColor: Colors.white,
        backgroundColor: Colors.grey,
        barRadius: const Radius.circular(8),
        animation: true,
        animationDuration: 3000,
        onAnimationEnd: (){
          Navigator.pop(context);
        },
      ),
    );
  }
}
