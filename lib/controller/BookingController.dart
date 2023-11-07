import 'dart:convert';

import 'package:av_hall_book/Utility.dart';
import 'package:av_hall_book/contant/Constants.dart';
import 'package:av_hall_book/model/AVHall.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/Booking.dart';
import '../model/TimeSlot.dart';
import '../model/User.dart';

class BookingController {
  static Future<bool> bookAVHall(AVHall hall, DateTime? selectedDate, String selectedYear, TimeSlot? selectedTimeSlot) async {
    final url = Constants.getUri('booking'); // Replace with your API endpoint
    User? user =  await Constants.getUserLocally();
    // Create a Map with the booking data
    final Map<String, dynamic> bookingData = {
      'userId': user?.id,
      'hallName': hall.name,
      'date': selectedDate?.toIso8601String(),
      'startTime': timeOfDayToSqlTime(selectedTimeSlot?.startTime),
      'endTime': timeOfDayToSqlTime(selectedTimeSlot?.endTime)
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(bookingData),
    );

    if (response.statusCode == 200) {
      // Booking was successful
      return true;
    } else {
      // Booking failed
      return false;
    }
  }

  static Future<List<Booking>> fetchBookingsByDate(DateTime selectedDate) async {
    try {
      User? user = await Constants.getUserLocally();
      final response = await http.post(
        Constants.getUri('booking/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": user?.id,
          "date": convertToSQLDate(selectedDate) , // Ensure you have a parseSQLDate function
        }),
      );
      print(selectedDate.toIso8601String());
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);
        final List<Booking> bookings = data.map((item) {
          final int id = item['id'];
          final String hallName = item['hallName'];
          final TimeOfDay startTime = parseSQLTime(item['startTime']); // Ensure you have a parseSQLTime function
          final TimeOfDay endTime = parseSQLTime(item['endTime']); // Ensure you have a parseSQLTime function
          final  date = item['date'].toString(); // Ensure you have a parseSQLDate function
          return Booking(
            id: id,
            hallName: hallName,
            startTime: startTime,
            endTime: endTime,
            date: date,
          );
        }).toList();
        return bookings;
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }
  static String convertToSQLDate(DateTime date) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }
}
