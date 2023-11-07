import 'package:flutter/material.dart';
import 'package:av_hall_book/controller/BookingController.dart';
import 'package:av_hall_book/model/Booking.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime? selectedDate;
  List<Booking> bookings = []; // List to store the bookings

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    fetchBookings(); // Fetch bookings when the page loads
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2021),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      fetchBookings(); // Fetch updated bookings when the date is changed
    }
  }

  Future<void> fetchBookings() async {
    try {
      final List<Booking> fetchedBookings =
      await BookingController.fetchBookingsByDate(selectedDate!);
      setState(() {
        bookings = fetchedBookings;
      });
    } catch (e) {
      // Handle error
      print('Error fetching bookings: $e');
    }
  }

  bool isBookingEnded(Booking booking) {
    final DateTime now = DateTime.now();
    final DateTime bookingEndTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      booking.endTime.hour,
      booking.endTime.minute,
    );
    return now.isAfter(bookingEndTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Date Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text(
                DateFormat('MMMM dd, yyyy').format(selectedDate!),
              ),
            ),
          ),

          // Booking List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchBookings(); // Fetch bookings when refreshing
              },
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final DateFormat timeFormat = DateFormat.Hm(); // Customize the time format (e.g., "HH:mm")

                  // Assuming that bookings[index].startTime and bookings[index].endTime are TimeOfDay objects
                  final TimeOfDay startTime = bookings[index].startTime;
                  final TimeOfDay endTime = bookings[index].endTime;

                  // Format TimeOfDay as a string
                  final String formattedStartTime = timeFormat.format(DateTime(0, 1, 1, startTime.hour, startTime.minute));
                  final String formattedEndTime = timeFormat.format(DateTime(0, 1, 1, endTime.hour, endTime.minute));

                  final bool ended = isBookingEnded(bookings[index]);

                  // Define a color for the border based on whether the booking has ended
                  final Color borderColor = ended ? Colors.red : Colors.green;

                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: borderColor, width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hall Name: ${bookings[index].hallName}'),
                          Text('Start Time: $formattedStartTime'),
                          Text('End Time: $formattedEndTime'),
                          if (ended)
                            Text(
                              'Previously Booked',
                              style: TextStyle(color: Colors.red),
                            )else Text('Upcoming Booking',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
