import 'package:flutter/material.dart';
import 'package:singlechildscrollview/const/colors.dart';
import 'package:singlechildscrollview/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      body: SingleChildScrollView(
        child: Column(
          children: numbers.map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          ).toList(),
        ),
      ),
    );
  }

  // 1
  // 기본 렌더링 법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 2
  // 화면을 넘어가지 않아도 스크롤 가능
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨.
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  // 3
  // widget이 잘리지 않게 하기

  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  // 4
  // 여러 physics 정렬
  Widget renderPhysics() {
    return SingleChildScrollView(
      // BouncingScrollPhysics(), 위 아래 bouncing 효과 추가. (IOS 스타일)
      // ClampingScrollPhysics(), 위 아래 bouncing 제거. (Android 스타일)
      physics: ClampingScrollPhysics(),
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 5
  // performance 한번에 다 rendering 하기 때문에 SingleChildScrollView를 무작정 사용하는 것은 좋지 않다.
  Widget  renderPerformance(){
    return SingleChildScrollView(
      child: Column(
        children: numbers.map(
              (e) => renderContainer(
            color: rainbowColors[e % rainbowColors.length],
            index: e,
          ),
        ).toList(),
      ),
    );
  }
  Widget renderContainer({required Color color,
  int? index}) {
    if(index != null){
      print(index);
    }
    return Container(
      height: 300,
      color: color,
    );
  }
}
