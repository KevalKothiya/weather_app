import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/globals/model_page.dart';
import 'package:http/http.dart' as http;

class DarkMode_Provider extends ChangeNotifier {
  DarkMode_Model darkMode_Model;

  DarkMode_Provider({
    required this.darkMode_Model,
  });

  AlternativeValue_Provided() async {
    darkMode_Model.isDark = !darkMode_Model.isDark;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setBool("isDark", darkMode_Model.isDark);

    notifyListeners();
  }
}

class NetWorkConnectivity_Provider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();

  NetWorkConnectivity_Model netWorkConnectivity_Model =
      NetWorkConnectivity_Model(
    netWorkStatus: "Waiting",
  );

  void checkInternetConnectivity() {
    netWorkConnectivity_Model.netWorkMode = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.wifi:
          netWorkConnectivity_Model.netWorkStatus = "Wifi";
          break;
        case ConnectivityResult.mobile:
          netWorkConnectivity_Model.netWorkStatus = "Mobile";
          break;
        case ConnectivityResult.other:
          netWorkConnectivity_Model.netWorkStatus = "Other Provieded";
          break;
        case ConnectivityResult.bluetooth:
          netWorkConnectivity_Model.netWorkStatus = "Bluetooth";
          break;
        case ConnectivityResult.vpn:
          netWorkConnectivity_Model.netWorkStatus = "vpn";
          break;
        case ConnectivityResult.ethernet:
          netWorkConnectivity_Model.netWorkStatus = "Ethernet";
          break;
        default:
          netWorkConnectivity_Model.netWorkStatus = "Waiting";
          break;
      }
    });
  }
}

class WeatherApi {
  WeatherApi._();

  static WeatherApi weatherApi = WeatherApi._();

  Future<Post?> fetchSingleTonData() async {
    String baseUrl = "http://api.weatherapi.com/v1/forecast.json";
    String key = "925228dcccd64c60a0d60359232405";
    String city = "Surat";

    String url = baseUrl + "?key=" + key + "&q=" + city;
    // String url = "https://api.weatherapi.com/v1/forecast.json?key=925228dcccd64c60a0d60359232405&q=Surat";

    http.Response res = await http.get(
      Uri.parse(url),
    );

    if (res.statusCode == 200){
      Map decodedData = jsonDecode(res.body);
      print('++++++++++++++++++++++++++++++++++');
      print(decodedData['forecast']['forecastday'][0]['hour'][5]['icon']);
      print('++++++++++++++++++++++++++++++++++');

      Post post = Post.data(data: decodedData);

      return post;
    }
    else{
      return null;
    }
  }
}
