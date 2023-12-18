import 'package:flutter/material.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';
import 'package:test_clima_flutter/utilities/constants.dart';
import 'dart:convert';
import 'package:test_clima_flutter/services/weather.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data, {super.key});
  String data;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp=0;
  int id=0;
  String city='', info='', weathericon='', weathermessage='';

  @override
  void initState() {
    super.initState();
    info = widget.data;
    updateUI();
  }

  void updateUI(){
    if (info == 'Error') {
      setState(() {
      });
    } else {
      setState(() {
        city = jsonDecode(info)['name'];
        id = jsonDecode(info)['weather'][0]['id'];
        temp = jsonDecode(info)['main']['temp'];
        print(city);
        print(id);
        print(temp);

        WeatherModel weatherModel = new WeatherModel();
        weathericon = weatherModel.getWeatherIcon(id);
        weathermessage = weatherModel.getMessage(temp.toInt());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      info = widget.data;
                      updateUI();
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String newcity;
                      info = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      print(info);
                      updateUI();
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
               Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      tempUpdate(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      iconUpdate(),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  promptUpdate(),
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String tempUpdate(){
    if (info == 'Error'){
      return 'Error';
    }
    else{
      return '${temp.toStringAsFixed(0)}°';
      }
  }

  String iconUpdate(){
    if (info == 'Error'){
      return '';
    }
    else{
      return weathericon;
    }
  }

  String promptUpdate(){
    if (info == 'Error'){
      return 'Cannot find data in city';
    }
    else{
      return '$weathermessage in $city!';
    }
  }
}
