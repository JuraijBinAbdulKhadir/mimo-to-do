import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:todo_app/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.blueAccent,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            LoadingAnimationWidget.twistingDots(leftDotColor: Colors.blueAccent, rightDotColor:Colors.green, size: 50)
          ],
        ),
      ),
    );
  }
}
