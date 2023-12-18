import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_clima_flutter/services/location.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';

class Networking{
  String appID = "df209a02f593eb58de51d471971c1347";
  double temp=0;
  int id=0;
  String data='', city='';

  Future<String> getData() async{
    Location location = new Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;

    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appID&units=metric");
    Response response = await get(url);
    data = response.body;

    if (response.statusCode == 200){
      return data;
    }else{
      return "Error";
    }
  }
}
