import 'package:flutter/material.dart';

class HorizontalListViewWidget extends StatelessWidget {
  const HorizontalListViewWidget(
      {required this.shrinkWrap, required this.size});

  final bool shrinkWrap;
  final int size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap ? ClampingScrollPhysics() : null,
        scrollDirection: Axis.horizontal,
        itemCount: size,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 60,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text('#tag$index'),
                ),
              ),
            ),
          );
        });
  }
}
