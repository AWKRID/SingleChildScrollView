import 'package:flutter/material.dart';
import 'package:singlechildscrollview/const/colors.dart';
import 'package:singlechildscrollview/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Reorderable List View Screen',
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return renderContainer(
            color: rainbowColors[numbers[index] % rainbowColors.length],
            index: numbers[index],
          );
        },
        itemCount: 100,
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          setState(
            () {
              final item = numbers.removeAt(oldIndex);
              numbers.insert(newIndex, item);
            },
          );
        },
      ),
    );
  }

  // 1
  // render default
  Widget renderDefault() {
    return ReorderableListView(
      // old new index 모두 옮기기 이전의 index로 선택
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        setState(
          () {
            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          },
        );
      },
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
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
