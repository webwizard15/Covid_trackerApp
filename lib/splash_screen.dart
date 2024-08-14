
import 'dart:async';

import 'package:covid_tracker/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget{
  const SplashScreen ({super.key});

  @override
  State <SplashScreen> createState() =>  _SplashScreenState();
}
 class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{  //TickerProviderStateMixin is a helper in Flutter that gives your widget the ability to provide a "ticker" to animations.
 late final AnimationController _controller = AnimationController(//animation controller requires context which is not available at this moment.
      duration: const Duration(seconds: 3),           //so we are
      vsync: this)..repeat();

 @override
 void dispose(){
   super.dispose();
   _controller.dispose();
 }

 void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStatsScreen(),))
    );
  }
    @override
    Widget build(BuildContext context){
     return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               AnimatedBuilder(
                 animation: _controller,
                 child: SizedBox(
                   height: MediaQuery.of(context).size.height * 0.5,
                   width:  MediaQuery.of(context).size.width * 0.5,
                   child:  Image(image: AssetImage("assets/virus.png"),),
                 ) ,
                 builder:(BuildContext context, Widget? child){
                   return Transform.rotate(
                       angle: _controller.value *2.0 * math.pi,
                      child: child,
                   );
                 },
               ),
            const Text("Covid-19\nTrackerApp",textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
 }