import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Card(
          elevation: 7,
          // color:const Color.fromARGB(255, 194, 215, 104),
          child: SizedBox(
            height: 400,width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                ),
                CircleAvatar(

                  radius: 70,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: const AssetImage('assets/image2.jpg'),

                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  // width: 250.0, // Set the width of the container
                  // height: 60.0, // Set the height of the container

                  color: Colors.grey[300], // Background color
                  child: const Text(
                    'Aditya Singh Raj-put',
                    style: TextStyle(
                      color: Colors.black, // Text color
                      fontSize: 20.0, // Text size
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[300], // Background color
                  child: const Text(
                    '9302082626',
                    style: TextStyle(
                      color: Colors.black, // Text color
                      fontSize: 20.0, // Text size
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
