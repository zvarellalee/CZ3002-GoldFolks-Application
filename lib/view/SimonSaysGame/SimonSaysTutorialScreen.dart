import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SimonSaysTutorialScreen extends StatelessWidget {
  static String id = "SimonSaysTutorialScreen";
  @override
  Widget build(BuildContext context) => SafeArea(
    child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Memorize the sequence',
          body: 'A sequence of squares will flash on the screen. Each round will add a new square to the sequence.',
          //image: _buildImage('assets/images/Search_Destination.png'), TODO: add tutorial images
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          title: 'Tap the sequence',
          body: 'After the sequence is done displaying, tap the squares in the same order that it was flashed in.',
          //image: _buildImage('assets/images/Search_Destination.png'), TODO: add tutorial images
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          title: 'Rules',
          body: 'You have 3 chances to tap the correct sequence. Try to see how far you can go!',
          //image: _buildImage('assets/images/Search_Destination.png'), TODO: add tutorial images
          decoration: _getPageDecoration(),
        ),
      ],
      done: Text(
        'Done',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onDone: () => Navigator.pop(context),
      showSkipButton: true,
      skip: Text('Skip'),
      onSkip: () => Navigator.pop(context),
      next: Icon(Icons.arrow_forward),
      dotsDecorator: _getDotDecoration(),
    ),
  );

  PageDecoration _getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(fontSize: 20),
    descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.white,
  );

  Widget _buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator _getDotDecoration() => DotsDecorator(
    color: Color(0xFFBDBDBD),
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );
}
