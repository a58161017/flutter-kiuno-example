import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class MultiListRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s multi-list',
      _MultiListWidget(),
    );
  }
}

class _MultiListWidget extends StatelessWidget {
  final List<String> idList = List.generate(10, (index) {
    return (index + 1).toString();
  });

  final List<int> colorValueList = List.generate(10, (index) {
    return 255 - index * 255 ~/ 10;
  });

  final List<String> englishList = List.generate(20, (index) {
    return generateWordPairs()
        .take(1)
        .map((e) => e.asPascalCase)
        .toList()
        .first;
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HorizontalListView(
          list: idList,
        ),
        _CustomDivider(),
        Expanded(child: _SimpleListView()),
        _CustomDivider(),
        Expanded(
            child: _ListViewBuilder(
          list: colorValueList,
        )),
        _CustomDivider(),
        Expanded(
            child: _ListViewSeparated(
          list: englishList,
        )),
        _CustomDivider(),
        Expanded(
            child: _ListViewDismissible(
          list: idList,
        )),
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      height: 20,
      color: Colors.black,
    );
  }
}

class _HorizontalListView extends StatelessWidget {
  const _HorizontalListView({required this.list});

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text('#tag${list[index]}'),
                ),
              ),
            );
          }),
    );
  }
}

class _SimpleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(
          child: Text(
            'Item1',
            style: TextStyle(fontSize: 32),
          ),
        ),
        const Center(
          child: Text(
            'Item2',
            style: TextStyle(fontSize: 32),
          ),
        ),
        const Center(
          child: Text(
            'Item3',
            style: TextStyle(fontSize: 32),
          ),
        ),
        const Center(
          child: Text(
            'Item4',
            style: TextStyle(fontSize: 32),
          ),
        ),
        const Center(
          child: Text(
            'Item5',
            style: TextStyle(fontSize: 32),
          ),
        ),
      ],
    );
  }
}

class _ListViewBuilder extends StatelessWidget {
  const _ListViewBuilder({required this.list});

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Color.fromARGB(
              255,
              list[index],
              list[index],
              list[index],
            ),
            child: Expanded(
              child: ListTile(),
            ),
          );
        });
  }
}

class _ListViewSeparated extends StatelessWidget {
  const _ListViewSeparated({required this.list});

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(list[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}

class _ListViewDismissible extends StatefulWidget {
  const _ListViewDismissible({required this.list});

  final List<String> list;

  @override
  _ListViewDismissibleState createState() => _ListViewDismissibleState();
}

class _ListViewDismissibleState extends State<_ListViewDismissible> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          final itemId = widget.list[index];
          return Dismissible(
            key: Key(itemId),
            onDismissed: (direction) {
              setState(() {
                widget.list.removeAt(index);
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$itemId dismissed')));
            },
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              title: Text('swipe item$itemId'),
            ),
          );
        });
  }
}
