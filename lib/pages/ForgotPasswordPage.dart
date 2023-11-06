import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password'),
          backgroundColor:const  Color.fromARGB(255, 41, 8, 134)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/image3.jpg',
              width: 300,
            ),
            const SizedBox(
              height: 23,
            ),
            const Text('Enter email to reset your password'),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                top: 20,
                bottom: 5,
              ),
              child: TextField(
                style: const TextStyle(color: Colors.red),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  fillColor: Colors.grey[300],
                  filled: true,
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor:const  Color.fromARGB(255, 41, 8, 134),
                padding: const EdgeInsets.only(
                  left: 60,
                  right: 60,
                  top: 10,
                  bottom: 10,

                ),
              ),
              child: const Text('Send Link'),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
