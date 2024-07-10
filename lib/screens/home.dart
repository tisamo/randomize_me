
import 'package:flutter/material.dart';
import 'package:randomize_me/shared/layout/simple_layout.dart';
import 'package:randomize_me/shared/text_styles.dart';

import '../shared/elements/BottomNav.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleLayout(layout:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text('Home', style: AppTextStyles.title),
                Padding(padding: EdgeInsets.only(top: 20),
                    child: Text('In this app you can select a course then you gonna get tasks in random order'))
              ],
            ),
          )
        ]), title: 'Home');



  }
}


