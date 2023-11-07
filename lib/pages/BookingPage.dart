import 'package:flutter/material.dart';

import '../controller/BookingController.dart';
import '../controller/TimeController.dart';
import '../dialogs/DialogHelper.dart';
import '../model/AVHall.dart';
import '../model/TimeSlot.dart';

class BookingPage extends StatefulWidget {

  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<TimeSlot> timeSlots = [];
  String selectedYear = "FIRSTYEAR"; // Default selected year
  DateTime? selectedDate;

  DateTime? lastSelectableDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    lastSelectableDate = selectedDate?.add(const Duration(days: 7));
    fetchTimeSlots();
  }

  Future<void> fetchTimeSlots() async {
    try {
      final List<TimeSlot> slots = await TimeController.fetchTimings(selectedYear);
      setState(() {
        timeSlots = slots;
      });
    } catch (e) {
      print('Failed to fetch time slots: $e');
    }
  }
  TimeSlot? selectedTimeSlot; // Variable to store the selected time slot

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Hall'),
        backgroundColor: const Color.fromARGB(255, 41, 8, 134),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 100,
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Select Year',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: "FIRSTYEAR",
                              groupValue: selectedYear,
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value!;
                                  fetchTimeSlots(); // Fetch time slots for the selected year
                                });
                              },
                            ),
                            const Text(
                              'First Year',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: "OTHERYEAR",
                              groupValue: selectedYear,
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value!;
                                  fetchTimeSlots(); // Fetch time slots for the selected year
                                });
                              },
                            ),
                            const Text(
                              'Other Year',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 80,
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Text(
                            'Select Date',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? datepicked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate!,
                              firstDate: selectedDate!,
                              lastDate: lastSelectableDate!,
                            );

                            if (datepicked != null) {
                              setState(() {
                                selectedDate = datepicked;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromARGB(255, 41, 8, 134),
                          ),
                          child: Text(
                            selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'Select Date',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (selectedYear == "FIRSTYEAR" || selectedYear == "OTHERYEAR")
              Expanded(
                child: ListView.builder(
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    final slot = timeSlots[index];
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedTimeSlot = slot; // Store the selected time slot
                        });
                        // Handle button click for the selected time slot
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 120, right: 120),
                        backgroundColor: selectedTimeSlot == slot
                            ? selectedButtonColor // Use selected button color for the selected item
                            : selectedYear == "FIRSTYEAR"
                            ? const Color.fromARGB(255, 41, 8, 134)
                            : Colors.lightGreen,
                      ),
                      child: Text('${slot.startTime?.hour.toString()} : ${slot.startTime?.minute.toString()} to ${slot.endTime?.hour.toString()} : ${slot.endTime?.minute.toString()}'),
                    );
                  },
                ),
              ),
            if (selectedYear == "FIRSTYEAR" || selectedYear == "OTHERYEAR")

              ElevatedButton(
                onPressed: () {
                  // Check if a time slot is selected
                  if (selectedTimeSlot != null) {
                    // Show the loading dialog
                    DialogHelper.showLoadingDialog(context);
                    final AVHall hall = ModalRoute.of(context)!.settings.arguments as AVHall;

                    // Perform the booking task using the BookingController
                    BookingController.bookAVHall(hall,selectedDate
                        ,selectedYear
                        , selectedTimeSlot
                    ).then((bookingSuccessful) {
                      // Hide the loading dialog
                      DialogHelper.hideLoadingDialog(context);

                      if (bookingSuccessful) {
                        // Booking was successful, navigate back to the previous page
                        Navigator.of(context).pop();
                      } else {
                        // Booking failed, show an error dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Booking Failed'),
                              content: Text('AV Hall is already booked for this time slot.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  backgroundColor: bookButtonColor, // Use the dynamic button color
                ),
                child: const Text("BOOK AV HALL"),
              ),


          ],
        ),
      ),
    );
  }

  Color bookButtonColor = const Color.fromARGB(255, 41, 8, 134); // Default button color
  Color selectedButtonColor = Colors.lightGreen;
}
