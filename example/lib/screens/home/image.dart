import 'package:flutter/material.dart';
import 'package:pixel_color_picker/pixel_color_picker.dart';

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Color? color;

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
        child: Center(
          child: Image.asset(
            'assets/colored_picture.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
