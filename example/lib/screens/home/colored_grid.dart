import 'package:flutter/material.dart';
import 'package:pixel_color_picker/pixel_color_picker.dart';

class ColoredGridScreen extends StatefulWidget {
  @override
  _ColoredGridScreenState createState() => _ColoredGridScreenState();
}

class _ColoredGridScreenState extends State<ColoredGridScreen> {
  Color? color;

  final _colors = [
    Colors.red,
    Colors.orange,
    Colors.brown,
    Colors.grey,
    Colors.deepPurple,
    Colors.purple,
    Colors.pink,
    Colors.blueGrey,
    Colors.green,
    Colors.yellow,
    Colors.deepOrange,
    Colors.red,
    Colors.indigo,
    Colors.teal,
    Colors.cyan,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: PixelColorPicker(
        onChanged: (color) {
          setState(() {
            this.color = color;
          });
        },
        child: GridView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            return Container(
              color: _colors[index],
            );
          },
          itemCount: _colors.length,
        ),
      ),
    );
  }
}
