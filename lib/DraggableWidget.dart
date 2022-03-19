import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'data.dart';

class GridViewPage extends StatefulWidget {
  GridViewPage({Key? key}) : super(key: key);

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  ///把每一个item添加到一个列表
  List<Widget> listWidget() {
    final List<Widget> list = [];
    for (int i = 0; i < urlList.length; i++) {
      list.add(itemWidget(i));
    }
    return list;
  }

  ///Item，裹上LongPressDraggable，使其可长按拖拽
  Widget itemWidget(int index) {
    return LongPressDraggable(
        data: index,

        ///组件拖拽的回调
        child: DragTarget<int>(
          onAccept: (data) {
            setState(() {
              final tem = urlList[data];
              urlList.remove(tem);
              urlList.insert(index, tem);
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              ///瀑布流布局核心代码
              height: index.isEven ? 200 : 250,
              child: Image.network(
                urlList[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),

        ///拖拽时候显示的组件
        feedback: Container(
          width: (MediaQuery.of(context).size.width - 10) / 2,
          height: index.isEven ? 200 : 250,
          child: Image.network(
            urlList[index],
            fit: BoxFit.cover,
          ),
        ));
  }

  ///流式布局
  Widget waterFall() {
    double spacing = 6;

    ///自由排布的gridview
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: urlList.length,
      itemBuilder: (BuildContext context, int index) => listWidget()[index],
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return waterFall();
  }
}
