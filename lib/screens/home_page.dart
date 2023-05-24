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
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: Stack(
          alignment: Alignment(0, -1.4),
          children: [
            Container(
              height: 7.h,
              width: double.infinity,
              color: Color(0xff2b3f64),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.only(
            left: 5.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.map,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.list_bullet,
                ),
              ),
            ],
          ),
        ),
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF252847),
                                borderRadius: BorderRadius.circular(4.h),
                              ),
                              padding: EdgeInsets.all(2.5.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Windy conditions from 17:30-21:30, with mostly clear conditions expected at 21:30",
                                      style: (Provider.of<DarkMode_Provider>(
                                                  context,
                                                  listen: false)
                                              .darkMode_Model
                                              .isDark)
                                          ? AppThemes.darkThemeData.textTheme
                                              .headlineLarge!
                                              .copyWith(
                                              fontSize: 2.h,
                                              fontWeight: FontWeight.w100,
                                            )
                                          : AppThemes.lightThemeData.textTheme
                                              .headlineLarge!
                                              .copyWith(
                                              color: Colors.white,
                                              fontSize: 2.h,
                                              fontWeight: FontWeight.w100,
                                            ),
                                    ),
                                    Divider(),
                                    Container(
                                      height: 15.h,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        itemCount: data.hour.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {
                                          return Container(
                                            height: 100,
                                            width: 17.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                3.h,
                                              ),
                                            ),
                                            margin: EdgeInsets.all(5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                (i < 10)
                                                    ? Text(
                                                        "0${i}:00",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        "${i}:00",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        "https:${data.hour[i]['condition']['icon']}",
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                (Provider.of<FarenheitMode_Provider>(
                                                            context,
                                                            listen: false)
                                                        .farenheitMode_Model
                                                        .isFarenheit)
                                                    ? Text(
                                                        data.hour[i]['temp_f']
                                                            .toString(),
                                                        style: (Provider.of<
                                                                        DarkMode_Provider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .darkMode_Model
                                                                .isDark)
                                                            ? AppThemes
                                                                .darkThemeData
                                                                .textTheme
                                                                .headlineLarge
                                                            : AppThemes
                                                                .lightThemeData
                                                                .textTheme
                                                                .headlineLarge!
                                                                .copyWith(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                      )
                                                    : Stack(
                                                        alignment:
                                                            Alignment(2, -1),
                                                        children: [
                                                          Text(
                                                            data.hour[i]
                                                                    ['temp_c']
                                                                .toString(),
                                                            style: (Provider.of<
                                                                            DarkMode_Provider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .darkMode_Model
                                                                    .isDark)
                                                                ? AppThemes
                                                                    .darkThemeData
                                                                    .textTheme
                                                                    .headlineLarge
                                                                : AppThemes
                                                                    .lightThemeData
                                                                    .textTheme
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                          ),
                                                          CircleAvatar(
                                                            radius: 0.5.h,
                                                            backgroundColor:
                                                                (Provider.of<DarkMode_Provider>(
                                                                            context)
                                                                        .darkMode_Model
                                                                        .isDark)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                            child: CircleAvatar(
                                                              radius: 0.25.h,
                                                              backgroundColor:
                                                                  (Provider.of<DarkMode_Provider>(
                                                                              context)
                                                                          .darkMode_Model
                                                                          .isDark)
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white,
                                                            ),
                                                          ),
                                                        ],
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
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 2.5.h,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, i) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.primaries[i % 18],
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: (i <= 2)
                                    ? (i <= 1)
                                        ? (i == 1)
                                // 1
                                            ? Column(
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         SizedBox(width: 4.w),
                                         Text("Sunrise"),
                                       ],
                                     ),
                                     Text(data.astro['sunrise'].toString()),
                                   ],
                                )
                                            : Text("0")
                                        : Text("2")
                                    : (i >= 4)
                                        ? (i == 4)
                                            ? Text("4")
                                            : Text("5")
                                        : Text("3"),
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 3,
                                mainAxisSpacing: 2.h,
                                crossAxisSpacing: 3.5.w,
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
