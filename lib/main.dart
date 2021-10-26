import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
void main() =>

  runApp(
    const MaterialApp(
      title: "weather app",
      home: Home(),
    )
  );
  class Home extends StatefulWidget
  {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
  return _HomeState();
      }
  }
class _HomeState extends  State<Home>
  {
    var temp;
    var description;
    var currently;
    var humidity;
    var windSpeed;

    Future getWeather() async{
      var url = Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=Lucknow&units=metric&appid=3996727d0c45cf12b567250e0cc44b55");
      var response  = await http.get(url);
      var results = jsonDecode(response.body);
      setState(()
      {
       this.temp = results['main']['temp'];  //getting the data and storing in above variables
       this.description = results['weather'][0] ['description'];
       this.currently = results['weather'] [0]['main'];
       this.humidity = results['main']['humidity'];
       this.windSpeed = results['wind']['speed'];
      });
    }
    @override
    void initState()
    {
      super.initState();
      this.getWeather();
    }

    @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      body: Column(
        children:<Widget> [
          Container(
            height: MediaQuery.of(context).size.height /3,
            width: MediaQuery.of(context).size.width,
            color: Colors.redAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text("Currently in Lucknow",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600
                  ),
                  ),
                 ),
                Text(
                  temp != null ? temp.toString() + "\u00b0" : "loading",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "loading",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>
              [
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: const Text("Temperature"),
                  trailing: Text(temp != null ? temp.toString() +"\u00b0" : "loading")
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.cloud),
                  title: const Text("Weather"),
                  trailing: Text(description != null? description.toString(): "loading"),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.sun),
                  title: const Text("humidity"),
                  trailing: Text(humidity!=null? humidity.toString() + "%":"loading"),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.wind),
                  title: const Text("Wind Speed"),
                  trailing: Text(windSpeed!=null? windSpeed.toString():"loading"),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }
  }

