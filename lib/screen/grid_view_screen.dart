import 'package:flutter/material.dart';
import 'package:singlechildscrollview/const/colors.dart';
import 'package:singlechildscrollview/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderMaxExtent(),
    );
  }

  // 1
  // 기본

  Widget renderCount() {
    return GridView.count(
      // crossAxisCount : 가로로 넣을 위젯의 개수
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      children: numbers
          .map(
            (e) =>
            renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
      )
          .toList(),
    );
  }

  // 2
  // 보이는 것만 rendering

  Widget renderbuilderCrossAxisCount() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length], index: index,);
      },
    );
  }

  // 3
  //최대 사이즈
  Widget renderMaxExtent(){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,

      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length], index: index,);
      },
    );
  }

  Widget renderContainer(
      {required Color color, required int index, double? height}) {
    return Container(
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
