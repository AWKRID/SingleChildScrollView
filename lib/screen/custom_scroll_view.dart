import 'package:flutter/material.dart';
import 'package:singlechildscrollview/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  // 최대 높이
  @override
  double get maxExtent => maxHeight;

  // 최소 높이
  @override
  double get minExtent => minHeight;

  // covariant - 상속된 class도 사용가능
  // oldDelegate build 전에 존재하던 delegate
  // 새로운 delegate -> this
  // shouldRebuild -> 새로 build를 할지 말지를 결정
  @override
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // sliver: 넣을 수 있는 위젯이 특정화 Sliver로 시작.
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderBuilderSilverList(),
          renderChildSliverGridBuilder(),
          renderHeader(),
          renderBuilderSilverList(),
        ],
      ),
    );
  }

  // ListView 기본 생성자와 유사
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList()),
    );
  }

  // ListView.builder 생성자와 유사

  SliverList renderBuilderSilverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
        childCount: 100,
      ),
    );
  }

  // GridView.count와 유사
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // GridView.builder와 유사
  Widget renderChildSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  // SliverAppbar
  // floating: true - 올릴 때 Appbar가 보인다.
  // pinned: true - Appbar가 고정
  // snap: true - 살짝 움직이는 방향으로 Appbar가 움직임. (floating이 true인 경우에만 쓸 수 있다)
  // strech: 최상단에서 아래로 scroll시 appbar의 아래 부분이 당겨져온다.
  // expandedHeight - Appbar의 크기를 증가.
  // flexiblespace : expandedHeight와 collapsedHeight에 따라 영역이 결정

  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      stretch: true,
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('FlexibleSpace'),
      ),
      title: Text('CustomScrolViewScreen'),
    );
  }

  // pinned - header가 쌓인다.
  SliverPersistentHeader renderHeader(){
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Text(
                'header',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          maxHeight: 250,
          minHeight: 100),
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
