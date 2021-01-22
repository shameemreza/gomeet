import 'package:flutter/material.dart';
import 'package:gomeet/utlis/constant.dart';

import 'ProfileScreen.dart';
import 'VideoConferenceScreen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageoptions = [VideoConferenceScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: myStyle(17, Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: myStyle(17, Colors.black),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Video Call',
            icon: Icon(
              Icons.video_call,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              Icons.person,
              size: 32,
            ),
          ),
        ],
      ),
      body: pageoptions[page],
    );
  }
}
