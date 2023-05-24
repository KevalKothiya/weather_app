

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/controller/controller_page.dart';
import 'package:weather_app/models/globals/model_page.dart';
import 'package:weather_app/models/utils/util.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/screens/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool isDark = await preferences.getBool('isDark') ?? false;
  bool isFarenheit = await preferences.getBool('isFarenheit') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DarkMode_Provider(darkMode_Model: DarkMode_Model(isDark: isDark))),
        ChangeNotifierProvider(create: (context) => FarenheitMode_Provider(farenheitMode_Model: FarenheitMode_Model(isFarenheit: isFarenheit))),
        ChangeNotifierProvider(create: (context) => NetWorkConnectivity_Provider(),),
      ],
      builder: (context, child) {
        return Sizer(
          builder: (context, _, __) {
            return MaterialApp(
              theme: AppThemes.lightThemeData,
              darkTheme: AppThemes.darkThemeData,
              themeMode: (Provider.of<DarkMode_Provider>(context)
                      .darkMode_Model
                      .isDark)
                  ? ThemeMode.dark
                  : ThemeMode.light,
              initialRoute: 'splashscreenPage',
              routes: {
                '/': (context) => HomeScreen(),
                'splashscreenPage': (context) => SplashScreen(),
              },
            );
          },
        );
      },
    ),
  );
}
