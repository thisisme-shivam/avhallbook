
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../contant/Constants.dart';
import '../model/AVHall.dart';

class AVHallController {
  static Future<List<AVHall>> fetchAVHalls()  async {
    final response = await http.get(Constants.getUri('avhalls'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<AVHall> halls = data.map((item) {
        final int id = item['id'];
        final String name = item['name'];
        return AVHall(id: id, name: name);
      }).toList();
    return halls;
    } else {
      throw Exception('Failed to load AV halls');
    }
  }


}
