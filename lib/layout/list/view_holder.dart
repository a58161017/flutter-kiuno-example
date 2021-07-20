import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class ViewHolderRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s view holder',
      _ViewHolderWidget(),
    );
  }
}

class _ViewHolderWidget extends StatelessWidget {
  final List<_Item> list = [
    _TitleItem(title: 'A類別'),
    _ContentItem(id: 1, content: 'Abs'),
    _ContentItem(id: 2, content: 'Age'),
    _ContentItem(id: 3, content: 'Apply'),
    _TitleItem(title: 'B類別'),
    _ContentItem(id: 1, content: 'Bank'),
    _ContentItem(id: 2, content: 'Because'),
    _ContentItem(id: 3, content: 'Book'),
    _ContentItem(id: 4, content: 'Bucket'),
    _TitleItem(title: 'C類別'),
    _ContentItem(id: 1, content: 'Car'),
    _ContentItem(id: 2, content: 'Cat'),
    _ContentItem(id: 3, content: 'Come'),
    _ContentItem(id: 4, content: 'Control'),
    _ContentItem(id: 5, content: 'Coordinator'),
    _ContentItem(id: 6, content: 'Cute'),
    _TitleItem(title: 'D類別'),
    _ContentItem(id: 1, content: 'Date'),
    _ContentItem(id: 2, content: 'Dead'),
    _ContentItem(id: 3, content: 'Done'),
    _ContentItem(id: 4, content: 'Due'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = list[index];
        if (item is _TitleItem) {
          return _TitleViewHolder(item: item);
        } else if (item is _ContentItem) {
          return _ContentViewHolder(item: item);
        } else {
          return Center(
            child: Text('#some error'),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey,
        );
      },
    );
  }
}

abstract class _Item {}

class _TitleItem extends _Item {
  _TitleItem({required this.title});

  final String title;
}

class _ContentItem extends _Item {
  _ContentItem({required this.id, required this.content});

  final int id;
  final String content;
}

class _TitleViewHolder extends StatelessWidget {
  const _TitleViewHolder({required this.item});

  final _TitleItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.greenAccent),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          item.title,
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _ContentViewHolder extends StatelessWidget {
  const _ContentViewHolder({required this.item});

  final _ContentItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(item.id.toString()),
              )),
          Expanded(flex: 10, child: Text(item.content)),
        ],
      ),
    );
  }
}
