import 'package:av_hall_book/contant/Constants.dart';
import 'package:av_hall_book/pages/BookingPage.dart';
import 'package:av_hall_book/pages/ForgotPasswordPage.dart';
import 'package:av_hall_book/pages/HomePage.dart';
import 'package:av_hall_book/pages/LoginPage.dart';
import 'package:flutter/material.dart';

import 'controller/UserController.dart';
import 'model/User.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<User?>(
        future: Constants.getUserLocally(), // Check if a user is already logged in
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state, you can display a loading indicator
            return CircularProgressIndicator(); // or any loading widget
          } else {
            if (snapshot.hasData) {
              // User data exists, navigate to the home page
              return const HomePage();
            } else {
              // User data doesn't exist, navigate to the login page
              return const LoginPage();
            }
          }
        },
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/bookhall': (context) => const BookingPage(),
        '/forgotpassword': (context) => const ForgotPasswordPage(),
      },
    );
  }
}
