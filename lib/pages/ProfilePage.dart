import 'package:av_hall_book/contant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/UserController.dart';
import '../model/User.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String phoneNumber = ''
      '';

  @override
  void initState() {
    super.initState();
    // Fetch user data when the page is initialized
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final User? user = await Constants.getUserLocally();
      setState(() {
        name = user!.firstname + " " + user.lastname;
        phoneNumber = user.phone;
      });
    } catch (e) {
      // Handle errors or show a message if data fetch fails
    }
  }

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
                  child:  Text(
                    name,
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
                  child:  Text(
                    phoneNumber,
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
