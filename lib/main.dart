import 'package:flutter/material.dart';
import 'Page/Goal.dart'; // Adjust the path as per your project structure
import 'models/Goal.dart'; // Adjust the path as per your project structure

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Splash Screen',
      theme: ThemeData(
        // Define your app theme here
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Set SplashScreen as the initial route
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a splash screen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the GoalPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GoalPage()), // Navigate to GoalPage.dart
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(), // Add a loading icon
            SizedBox(height: 20), // Add some spacing
            Text('Loading...'), // Optional: Add a loading text
          ],
        ),
      ),
    );
  }
}
