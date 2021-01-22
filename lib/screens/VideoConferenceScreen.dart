import 'package:flutter/material.dart';
import 'package:gomeet/utlis/constant.dart';
import 'package:gomeet/videoconf/CreateMeeting.dart';
import 'package:gomeet/videoconf/JoinMeeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  VideoConferenceScreen({Key key}) : super(key: key);

  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  buildtab(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            name,
            style: myStyle(16, Colors.black, FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text(
          "GoMeet",
          style: myStyle(20, Colors.white, FontWeight.w700),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [buildtab("Join Room"), buildtab("Create Room")],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [JoinMeeting(), CreateMeeting()],
      ),
    );
  }
}
