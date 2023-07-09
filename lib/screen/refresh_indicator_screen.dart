import 'package:flutter/material.dart';
import 'package:singlechildscrollview/layout/main_layout.dart';

import '../const/colors.dart';

class RefreshIndicatorScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  RefreshIndicatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'RefreshIndicatorScreen',
      body: RefreshIndicator(
        onRefresh: () async{
          await Future.delayed(Duration(seconds: 3));
        },
        child: ListView(
          children: numbers
              .map((e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e))
              .toList(),
        ),
      ),
    );
  }

  Widget renderContainer(
      {required Color color, required int index, double? height}) {
    return Container(
      // key 값이 다르면 다른 container로 인식
      key: Key(index.toString()),
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
