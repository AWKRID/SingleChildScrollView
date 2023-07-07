import 'package:flutter/material.dart';
import 'package:singlechildscrollview/const/colors.dart';
import 'package:singlechildscrollview/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparated(),
    );
  }

  // 1
  // SingleChildScrollView와 동일하게 전부 다 rendering

  Widget renderDefault() {
    return ListView(
        children: numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList());
  }

  // 2
  // scroll에 따라 추가적으로 rendering => performance에 매우 좋다.

  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      },
    );
  }

  // 3
  // 중간중간에 추가할 위젯을 넣을 수 있다.

  Widget renderSeparated() {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      },
      // 중간 중간에 sepaeratorbuilder가 실행
      // 배너 광고 같은 것 넣을 때 굉장히 유용하다.
      separatorBuilder: (context, index) {
        index += 1;
        if (index % 5 == 0) {
          return renderContainer(
              color: Colors.black, index: index, height: 100);
        }
        return Container();
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
