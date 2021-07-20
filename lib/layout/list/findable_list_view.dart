import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

import '../../base.dart';

class FindableListViewRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s findable list view',
      _FindableListViewWidget(),
    );
  }
}

class _FindableListViewWidget extends StatefulWidget {
  @override
  _FindableListViewState createState() => _FindableListViewState();
}

class _FindableListViewState extends State<_FindableListViewWidget> {
  var _listViewKey = RectGetter.createGlobalKey();
  var _listItemKeys = {};

  var _titleText = '';
  var _needTitleTip = false;

  void _enabledTitleTip(bool enabled) {
    setState(() => _needTitleTip = enabled);
  }

  void _changeTitleText(String text) {
    setState(() => _titleText = text);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            final indexList = getVisible();
            var enabled = indexList[0] >= 10;
            _enabledTitleTip(enabled);
            if (enabled) {
              _changeTitleText(indexList[0].toString());
            }
            debugPrint(indexList.toString());
            return true; // Can't continue to pass to the parent widget.
          },
          child: RectGetter(
            key: _listViewKey,
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                _listItemKeys[index] = RectGetter.createGlobalKey();
                return RectGetter(
                  key: _listItemKeys[index],
                  child: ListTile(
                    title: Center(child: Text(index.toString())),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Visibility(
            visible: _needTitleTip,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.green),
              child: Center(
                child: Text(
                  _titleText,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<int> getVisible() {
    /// First, get the rect of ListView, and then traver the _keys
    /// get rect of each item by keys in _keys, and if this rect in the range of ListView's rect,
    /// add the index into result list.
    var listRect = RectGetter.getRectFromKey(_listViewKey);
    var _indexOfItems = <int>[];
    _listItemKeys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);
      if (itemRect != null && listRect != null) {
        if (!(itemRect.top > listRect.bottom ||
            itemRect.bottom < listRect.top)) {
          _indexOfItems.add(index);
        }
      }
    });

    /// so all visible item's index are in this _items.
    return _indexOfItems;
  }
}
