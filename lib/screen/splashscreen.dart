
import 'package:flutter/material.dart';
import 'package:reports/screen/homePage.dart';
import 'package:reports/screen/level1.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  navigate() async {
    await Future.delayed(Duration(seconds: 2), () async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LevelOne()),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceInOut,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: const Center(
          child: Text(
            "Reports",
            style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}
