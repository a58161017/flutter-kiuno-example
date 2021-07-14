import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

import '../../base.dart';

class FindableListViewRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Findable List View',
      'Kiuno\'s findable list view',
      _FindableListViewWidget(),
    );
  }
}

class _FindableListViewWidget extends StatelessWidget {
  var _listViewKey = RectGetter.createGlobalKey();
  var _listItemKeys = {};

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        debugPrint(getVisible().toString());
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
