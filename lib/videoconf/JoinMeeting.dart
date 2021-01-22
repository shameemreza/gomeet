import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:gomeet/utlis/constant.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  JoinMeeting({Key key}) : super(key: key);

  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String username = '';

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
    });
  }

  joinmeeting() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlag.callIntegrationEnabled = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlag.pipEnabled = false;
      }

      var options = JitsiMeetingOptions()
        ..room = roomcontroller.text
        ..userDisplayName =
            namecontroller.text == '' ? username : namecontroller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlag = featureFlag;

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                "Room Code",
                style: myStyle(20),
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                controller: roomcontroller,
                appContext: context,
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                animationDuration: Duration(milliseconds: 300),
                length: 6,
                onChanged: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                style: myStyle(20),
                controller: namecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Your Name (Optional)",
                  labelStyle: myStyle(15),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value;
                  });
                },
                title: Text(
                  "Video Muted",
                  style: myStyle(18, Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  "Audio Muted",
                  style: myStyle(18, Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("You will be able to change your setting on meeting page.",
                  style: myStyle(15), textAlign: TextAlign.center),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () => joinmeeting(),
                child: Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: GradientColors.facebookMessenger)),
                  child: Center(
                    child: Text(
                      "Join Meeting",
                      style: myStyle(20, Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
