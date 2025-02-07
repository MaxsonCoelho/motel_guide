import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motel_guide/screens/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreloadScreen extends StatefulWidget {
  @override
  _PreloadScreenState createState() => _PreloadScreenState();
}

class _PreloadScreenState extends State<PreloadScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000), 
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.3, curve: Curves.easeIn)),
    );

    Future.delayed(Duration(seconds: 2), () {
      _controller.forward();
    });

    _scaleAnimation = Tween<double>(begin: 1.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn)),
    );

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 40), 
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 60),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 17, 0), 
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: SvgPicture.asset(
                  'assets/images/logo-guia-de-moteis.svg',
                  width: 300, 
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
