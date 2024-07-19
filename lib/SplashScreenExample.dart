
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'HomePageExample.dart';

class SplashScreenExample extends StatefulWidget {
  const SplashScreenExample({super.key});

  @override
  State<SplashScreenExample> createState() => _SplashScreenExampleState();
}

class _SplashScreenExampleState extends State<SplashScreenExample> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePageExample()));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/img/todolist.json",height: 120.0,),
          ],
        ),
      ),

    );
  }
}
