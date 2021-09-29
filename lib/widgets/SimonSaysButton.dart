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
  Animation<Color> _animation;
  AnimationController _controller;
  StreamSubscription _subscription;
  int _duration = 500;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: _duration),
      vsync: this
    );

    _animation = ColorTween(
      begin: Colors.lightBlue[800],
      end: Colors.white,
    ).animate(CurvedAnimation(
        parent: _controller,
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
        _controller.forward();
        Timer(
        Duration(milliseconds: _duration), () {
        _controller.reverse();
        });
      }
    });
  }

  @override
  dispose() {
    _controller?.dispose();
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
          backgroundColor: MaterialStateProperty.all<Color>(_animation.value),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(double.infinity, 30),
          )),
      /*
      child: Container(
        padding: const EdgeInsets.all(8),
        //color: Colors.blue,
        decoration: BoxDecoration(
          color: _animation.value,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
       */
    );
  }
}