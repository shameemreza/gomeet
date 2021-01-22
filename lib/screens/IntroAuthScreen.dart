import 'package:flutter/material.dart';
import 'package:gomeet/auth/NavAuthScreen.dart';
import 'package:gomeet/utlis/constant.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroAuthScreen extends StatelessWidget {
  const IntroAuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to GoMeet",
          body: "One consistent enterprise experience for all use cases",
          image: Center(
            child: Image.asset('assets/images/welcome.png', height: 175),
          ),
          decoration: PageDecoration(
              bodyTextStyle: myStyle(20, Colors.black),
              titleTextStyle: myStyle(20, Colors.black)),
        ),
        PageViewModel(
          title: "Meetings & Chat",
          body: "Online Meetings, Training & Technical Support",
          image: Center(
            child: Image.asset('assets/images/secure.png', height: 175),
          ),
          decoration: PageDecoration(
              bodyTextStyle: myStyle(20, Colors.black),
              titleTextStyle: myStyle(20, Colors.black)),
        ),
        PageViewModel(
          title: "Video Webinar",
          body: "Marketing Events & Town Hall Meetings",
          image: Center(
            child: Image.asset('assets/images/conference.png', height: 175),
          ),
          decoration: PageDecoration(
              bodyTextStyle: myStyle(20, Colors.black),
              titleTextStyle: myStyle(20, Colors.black)),
        ),
      ],
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
      },
      onSkip: () {},
      showNextButton: true,
      skip: const Icon(Icons.skip_next, size: 45),
      next: const Icon(Icons.arrow_forward_ios),
      done: Text(
        "Done",
        style: myStyle(20, Colors.black),
      ),
    );
  }
}
