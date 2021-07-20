import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';
import 'package:flutter_kiuno_example/widget/horizontal_list_view.dart';
import 'package:flutter_kiuno_example/widget/vertical_list_view.dart';

class NestedListView2Route extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s nested listView2',
      _NestedListView2Widget(),
    );
  }
}

class _NestedListView2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        if (index % 2 == 0) {
          return Container(
            height: 60,
            child: HorizontalListViewWidget(shrinkWrap: false, size: 10),
          );
        } else {
          return VerticalListViewWidget(shrinkWrap: true, size: 10);
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}
