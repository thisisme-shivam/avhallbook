
import 'package:flutter/material.dart';

String timeOfDayToSqlTime(TimeOfDay? time) {
  if(time == null){
    return "";
  }
  final formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
  return formattedTime;
}