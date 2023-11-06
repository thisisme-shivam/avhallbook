import 'package:av_hall_book/pages/BookingPage.dart';
import 'package:av_hall_book/pages/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      home: const HomePage(),


      initialRoute: '/',
      routes: {


        '/bookhall': (context) => const BookingPage(),
      },
    );
  }
}
