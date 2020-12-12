import 'package:flutter/material.dart';
import 'colored_grid.dart';
import 'image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Colored Grid',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ColoredGridScreen();
                    },
                  ),
                );
              },
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Image',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ImageScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
