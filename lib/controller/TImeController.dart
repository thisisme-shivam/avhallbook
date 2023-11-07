
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utility.dart';
import '../contant/Constants.dart';
import '../model/TimeSlot.dart';
class TimeController {
  // Function to fetch timings for a specific year
  static Future<List<TimeSlot>> fetchTimings(String year) async {
    try {
      final response = await http.get(Constants.getUri('/timeslot/$year'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<TimeSlot> timings = data.map((item) {
          return TimeSlot(
            id: item['id'],
            startTime: parseSQLTime(item['startTime']),
            endTime: parseSQLTime(item['endTime']),
            year: year,
            lunchTime: parseSQLTime(item['lunchTime']),
          );
        }).toList();

        return timings;
      } else {
        throw Exception('Failed to load timings');
      }
    } catch (e) {
      // Handle network or other exceptions
      throw Exception('Failed to fetch timings: $e');
    }
  }

  static TimeOfDay parseSQLTime(String? sqlTime) {
    if(sqlTime == null){
      return TimeOfDay(hour: 0, minute: 0);
    }
    final parts = sqlTime!.split(':');
    if (parts.length == 3) {
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    }
    return TimeOfDay(hour: 0, minute: 0); // Default value if parsing fails
  }
}
