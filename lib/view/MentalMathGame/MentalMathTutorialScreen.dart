import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class MentalMathTutorialScreen extends StatelessWidget {
  static String id = "MentalMathTutorialScreen";
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Solve the problem',
              body: 'A problem will be displayed at the center of the screen.',
              image: _buildImage('images/mental_1.jpeg'),
              decoration: _getPageDecoration(),
            ),
            PageViewModel(
              title: 'Select your answer',
              body: 'Choose the correct answer by tapping on its box.',
              image: _buildImage('images/mental_2.jpeg'),
              decoration: _getPageDecoration(),
            ),
            PageViewModel(
              title: 'Rules',
              body:
                  'You will have 60 seconds to answer as many questions as you can. Have fun!',
              image: _buildImage('images/mental_3.jpeg'),
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
