import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goldfolks/controller/SimonSaysController.dart';

class SimonSaysButton extends StatefulWidget {
  final int buttonIndex;
  const SimonSaysButton ({ Key key, this.buttonIndex }): super(key: key);

  @override
  _SimonSaysButtonState createState() => _SimonSaysButtonState();
}

class _SimonSaysButtonState extends State<SimonSaysButton>
  with TickerProviderStateMixin{
  Animation<Color> _animationAI;
  AnimationController _aiAnimation;
  StreamSubscription _subscription;
  int _durationAI = 500;

  @override
  void initState() {
    super.initState();
    _aiAnimation = AnimationController(
      duration: Duration(milliseconds: _durationAI),
      vsync: this
    );

    _animationAI = ColorTween(
      begin: Colors.lightBlue[800],
      end: Colors.white,
    ).animate(CurvedAnimation(
        parent: _aiAnimation,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.ease,
      )..addListener(() {
      setState(() {});
    }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var animationStream = SimonSaysController.controller;
    //_subscription?.cancel();
    _subscription = animationStream.stream.listen((value) {
      if (value == widget.buttonIndex) {
        _aiAnimation.forward();
        Timer(
        Duration(milliseconds: _durationAI), () {
        _aiAnimation.reverse();
        });
      }
    });
  }

  @override
  dispose() {
    _aiAnimation?.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        SimonSaysController.checkMove(widget.buttonIndex);
        },
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith(
                (states) {
              return (states.contains(MaterialState.pressed) && SimonSaysController.canPlay)
                  ? Colors.white
                  : null;
            },
          ),
          backgroundColor: MaterialStateProperty.all<Color>(_animationAI.value),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(double.infinity, 30),
          )), child: null,
    );
  }
}