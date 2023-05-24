import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/controller/controller_page.dart';
import 'package:weather_app/models/utils/util.dart';

import '../models/globals/model_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<NetWorkConnectivity_Provider>(context, listen: false)
        .checkInternetConnectivity();

    WeatherApi.weatherApi.fetchSingleTonData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: (Provider.of<NetWorkConnectivity_Provider>(context)
                    .netWorkConnectivity_Model
                    .netWorkStatus ==
                "Waiting")
            ? Container(
                alignment: Alignment.center,
                child: Text(Provider.of<NetWorkConnectivity_Provider>(context)
                    .netWorkConnectivity_Model
                    .netWorkStatus),
              )
            : FutureBuilder(
                future: WeatherApi.weatherApi.fetchSingleTonData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    Post? data = snapshot.data;

                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          collapsedHeight: 14.h,
                          expandedHeight: 45.h,
                          centerTitle: true,
                          pinned: true,
                          leading: IconButton(
                            onPressed: () {
                              print(data!.hour[0]['icon'].toString());
                            },
                            icon: Icon(
                              Icons.menu,
                            ),
                          ),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Provider.of<DarkMode_Provider>(context,
                                        listen: false)
                                    .AlternativeValue_Provided();
                              },
                              icon: Icon(
                                CupertinoIcons.settings,
                              ),
                            ),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Text(
                                    data!.nameOfCity,
                                    style:
                                        (Provider.of<DarkMode_Provider>(context)
                                                .darkMode_Model
                                                .isDark)
                                            ? AppThemes.darkThemeData.textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                fontWeight: FontWeight.w300,
                                              )
                                            : AppThemes.lightThemeData.textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                fontWeight: FontWeight.w300,
                                              ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Spacer(
                                        flex: 4,
                                      ),
                                      Text(
                                        data!.tempInCelcius.toString(),
                                        style: (Provider.of<DarkMode_Provider>(
                                                    context)
                                                .darkMode_Model
                                                .isDark)
                                            ? AppThemes.darkThemeData.textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                fontSize: 6.h,
                                                fontWeight: FontWeight.w300,
                                              )
                                            : AppThemes.lightThemeData.textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                fontSize: 6.h,
                                                fontWeight: FontWeight.w300,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      CircleAvatar(
                                        radius: 0.9.h,
                                        backgroundColor:
                                            (Provider.of<DarkMode_Provider>(
                                                        context)
                                                    .darkMode_Model
                                                    .isDark)
                                                ? Colors.white
                                                : Colors.black,
                                        child: CircleAvatar(
                                          radius: 0.65.h,
                                          backgroundColor:
                                              (Provider.of<DarkMode_Provider>(
                                                          context)
                                                      .darkMode_Model
                                                      .isDark)
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                      ),
                                      Spacer(
                                        flex: 3,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                            collapseMode: CollapseMode.pin,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(2.5.h),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      "Windy conditions from 17:30-21:30, with mostly clear conditions expected at 21:30"),
                                  Divider(),
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    color: Colors.yellow,
                                    child: ListView.builder(
                                      itemCount: data.hour.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          height: 100,
                                          width: 17.w,
                                          decoration: BoxDecoration(
                                            color: Colors.primaries[i % 18].shade200,
                                            borderRadius: BorderRadius.circular(
                                              3.h,
                                            ),
                                          ),
                                          margin: EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.hour[i]['temp_c']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              // Image(
                                              //   image: NetworkImage(
                                              //       "https:${data.hour[0]['icon']}"),
                                              // ),
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https:${data.hour[i]['condition']['icon']}",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                data.tempInFarenheit.toString(),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                },
              ),
      ),
    );
  }
}
