import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag; //url of asset
  String url;
  bool isDayTime;

  WorldTime(
      {this.location, this.flag, this.url}); //location url of server endpoint

  Future<void> getData() async {
    try {
      Response response =
          await get('https://worldtimeapi.org/api/timezone/$url');
      //print(response.body);
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = ((now.hour > 6) && (now.hour < 20)) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'Could not update time';
    }
  }
}
