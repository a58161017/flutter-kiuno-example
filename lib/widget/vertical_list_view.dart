import 'package:flutter/material.dart';

class VerticalListViewWidget extends StatelessWidget {
  const VerticalListViewWidget({required this.shrinkWrap, required this.size});

  final bool shrinkWrap;
  final int size;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? ClampingScrollPhysics() : null,
      itemCount: size,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 60,
          height: 40,
          child: Center(
            child: Text('Item$index'),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}
