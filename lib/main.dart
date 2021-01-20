import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Gallery📷';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Photos',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Collections',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: Favourite',
  //     style: optionStyle,
  //   ),
  // ];

  Future<void> getData() async {
    var imagePath = null;
    try {
      imagePath = await StoragePath.imagesPath; //contains images path and folder name in json format
    } on PlatformException {
      var imagesPath = 'Failed to get path';
    }
    //print(jsonEncode(imagePath));
    print("the folders are"+ jsonEncode(imagePath.files));
    //print(imagePath);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0) {
        HapticFeedback.heavyImpact();
        getData();
        print("going to Photos widget");
      }
      if(_selectedIndex == 1) {
        HapticFeedback.heavyImpact();
        print("going to Collections widget");
      }
      if(_selectedIndex == 2) {
        HapticFeedback.heavyImpact();
        print("going to Favourites widget");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: Center(
        //child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.indigo,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
