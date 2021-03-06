import 'package:flutter/material.dart';

class Searcher extends StatelessWidget {
  final Function(Offset offset)? onSearch;

  const Searcher({
    Key? key,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black.withOpacity(.2),
            width: 2,
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
