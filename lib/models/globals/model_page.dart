import 'dart:async';

class DarkMode_Model {
  bool isDark;

  DarkMode_Model({
    required this.isDark,
  });
}

class NetWorkConnectivity_Model {
  String netWorkStatus;
  StreamSubscription? netWorkMode;

  NetWorkConnectivity_Model({
    required this.netWorkStatus,
    this.netWorkMode,
  });
}

class Post {
  String nameOfCity;
  String nameOfRegion;
  String nameOfCountry;
  String time;
  String date;
  // String iconImage;
  double tempInCelcius;
  double tempInFarenheit;
  double windSpeedInMPH;
  double windSpeedInKPH;
  List hour;

  Post({
    required this.nameOfCity,
    required this.nameOfRegion,
    required this.nameOfCountry,
    required this.time,
    required this.date,
    // required this.iconImage,
    required this.tempInCelcius,
    required this.tempInFarenheit,
    required this.windSpeedInMPH,
    required this.windSpeedInKPH,
    required this.hour,
  });

  factory Post.data({required Map data}) {
    return Post(
      nameOfCity: data['location']['name'],
      nameOfRegion: data['location']['region'],
      nameOfCountry: data['location']['country'],
      time: data['location']['localtime'],
      date: data['location']['localtime'],
      // iconImage: data['current']['icon'],
      tempInCelcius: data['current']['temp_c'],
      tempInFarenheit: data['current']['temp_f'],
      windSpeedInMPH: data['current']['wind_mph'],
      windSpeedInKPH: data['current']['wind_kph'],
      hour: data['forecast']['forecastday'][0]['hour'],
    );
  }
}
