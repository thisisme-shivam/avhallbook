import 'package:flutter/material.dart';

class AVHallPage extends StatefulWidget {
  const AVHallPage({Key? key}) : super(key: key);

  @override
  State<AVHallPage> createState() => _AVHallPageState();
}

class _AVHallPageState extends State<AVHallPage> {
  final List<String> avHallNames = ['ME AV HALL', 'CSE AV HALL', 'AIDS AV HALL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: avHallNames.map((title) {
            return buildClickableCard(context, title);
          }).toList(),
        ),
      ),
    );
  }

  Widget buildClickableCard(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/bookhall');
        // Handle the click event here
        // You can navigate to another screen or perform any other action
        print('Clicked on $title');
      },
      child: SizedBox(
        height: 100,
        width: 350,
        child: Card(
          elevation: 6,

          child: Column(
            children: [
              Container(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
