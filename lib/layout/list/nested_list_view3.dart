import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';
import 'package:flutter_kiuno_example/widget/horizontal_list_view.dart';
import 'package:flutter_kiuno_example/widget/vertical_list_view.dart';

class NestedListView3Route extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s nested listView3',
      _NestedListView3Widget(),
    );
  }
}

class _NestedListView3Widget extends StatelessWidget {
  final List<_Item> list = [
    _HorizontalListItem(),
    _NormalItem(id: 0),
    _NormalItem(id: 1),
    _NormalItem(id: 2),
    _NormalItem(id: 3),
    _NormalItem(id: 4),
    _NormalItem(id: 5),
    _NormalItem(id: 6),
    _NormalItem(id: 7),
    _NormalItem(id: 8),
    _NormalItem(id: 9),
    _HorizontalListItem(),
    _NormalItem(id: 0),
    _NormalItem(id: 1),
    _NormalItem(id: 2),
    _NormalItem(id: 3),
    _NormalItem(id: 4),
    _NormalItem(id: 5),
    _NormalItem(id: 6),
    _NormalItem(id: 7),
    _NormalItem(id: 8),
    _NormalItem(id: 9),
    _HorizontalListItem(),
    _NormalItem(id: 0),
    _NormalItem(id: 1),
    _NormalItem(id: 2),
    _NormalItem(id: 3),
    _NormalItem(id: 4),
    _NormalItem(id: 5),
    _NormalItem(id: 6),
    _NormalItem(id: 7),
    _NormalItem(id: 8),
    _NormalItem(id: 9),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = list[index];
        if (item is _HorizontalListItem) {
          return _HorizontalListViewHolder(item: item);
        } else if (item is _NormalItem) {
          return _NormalViewHolder(item: item);
        } else {
          return Text('#some error');
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}

abstract class _Item {}

class _HorizontalListItem extends _Item {}

class _NormalItem extends _Item {
  _NormalItem({required this.id});

  final int id;
}

class _HorizontalListViewHolder extends StatelessWidget {
  const _HorizontalListViewHolder({required this.item});

  final _HorizontalListItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: HorizontalListViewWidget(shrinkWrap: false, size: 10),
    );
  }
}

class _NormalViewHolder extends StatelessWidget {
  const _NormalViewHolder({required this.item});

  final _NormalItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 40,
      child: Center(
        child: Text('Item${item.id}'),
      ),
    );
  }
}
