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
  late Future<Post?> fetch;

  @override
  void initState() {
    super.initState();

    Provider.of<NetWorkConnectivity_Provider>(context, listen: false)
        .checkInternetConnectivity();

    fetch = WeatherApi.weatherApi.fetchSingleTonData(
      city: "Surat",
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: SingleChildScrollView(
          child: Stack(
            alignment: const Alignment(0, -1.15),
            children: [
              Container(
                height: 15.h,
                width: double.infinity,
                color: (Provider.of<DarkMode_Provider>(context, listen: false)
                        .darkMode_Model
                        .isDark)
                    ? const Color(0xff2b3f64).withOpacity(
                        0.1,
                      )
                    : const Color(0xff2b3f64).withOpacity(0.8),
              ),
              const Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.only(
            left: 5.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: TextEditingController(),
                  onSubmitted: (val) {
                    setState(() {
                      fetch =
                          WeatherApi.weatherApi.fetchSingleTonData(city: val);
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.map,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.list_bullet,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        (Provider.of<DarkMode_Provider>(context, listen: false)
                                .darkMode_Model
                                .isDark)
                            ? const AssetImage("assest/images/dark.gif")
                            : const AssetImage("assest/images/light.gif"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FutureBuilder(
                  future: fetch,
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
                            backgroundColor: Colors.black87,
                            centerTitle: true,
                            pinned: true,
                            leading: IconButton(
                              onPressed: () {
                                print(data!.hour[0]['icon'].toString());
                              },
                              icon: const Icon(
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
                                icon: const Icon(
                                  CupertinoIcons.settings,
                                ),
                              ),
                            ],
                            flexibleSpace: FlexibleSpaceBar(
                              background: (Provider.of<DarkMode_Provider>(
                                          context,
                                          listen: false)
                                      .darkMode_Model
                                      .isDark)
                                  ? const Image(
                                      image:
                                          AssetImage("assest/images/dark.gif"),
                                      fit: BoxFit.cover,
                                    )
                                  : const Image(
                                      image:
                                          AssetImage("assest/images/light.gif"),
                                      fit: BoxFit.cover,
                                    ),
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
                                      style: (Provider.of<DarkMode_Provider>(
                                                  context)
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
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(
                                          flex: 4,
                                        ),
                                        Text(
                                          data!.tempInCelcius.toString(),
                                          style: (Provider.of<
                                                          DarkMode_Provider>(
                                                      context)
                                                  .darkMode_Model
                                                  .isDark)
                                              ? AppThemes.darkThemeData
                                                  .textTheme.headlineLarge!
                                                  .copyWith(
                                                  fontSize: 6.h,
                                                  fontWeight: FontWeight.w300,
                                                )
                                              : AppThemes.lightThemeData
                                                  .textTheme.headlineLarge!
                                                  .copyWith(
                                                  color: Colors.white,
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
                                                  : Colors.white,
                                          child: CircleAvatar(
                                            radius: 0.65.h,
                                            backgroundColor: (Provider.of<
                                                            DarkMode_Provider>(
                                                        context)
                                                    .darkMode_Model
                                                    .isDark)
                                                ? Colors.black.withOpacity(0.5)
                                                : Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        const Spacer(
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
                                  color: const Color(0xFF252847),
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
                                      const Divider(),
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
                                              margin: const EdgeInsets.all(5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  (i < 10)
                                                      ? Text(
                                                          "0${i}:00",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        )
                                                      : Text(
                                                          "${i}:00",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
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
                                                              const Alignment(
                                                                  2, -1),
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
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 0.25.h,
                                                                backgroundColor: (Provider.of<DarkMode_Provider>(
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
                                    color: const Color(0xff2a3759),
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
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        const Icon(
                                                          CupertinoIcons
                                                              .sunset_fill,
                                                          color:
                                                              Color(0xff4c5372),
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Text(
                                                          "SUNSET",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: const Color(
                                                                      0xff4c5372),
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: const Color(
                                                                      0xff4c5372),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        Text(
                                                          data.astro['sunset']
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Container(
                                                      height: 2.h,
                                                      width: 2.w,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.white,
                                                            blurRadius: 5,
                                                            spreadRadius: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    const Divider(),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        Text(
                                                          "Sunrise: ",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                ),
                                                        ),
                                                        Text(
                                                          data.astro['sunrise'],
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              // 0
                                              : Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        const Icon(
                                                          CupertinoIcons
                                                              .sun_max_fill,
                                                          color:
                                                              Color(0xff4c5372),
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Text(
                                                          "UV INDEX",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: const Color(
                                                                      0xff4c5372),
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: const Color(
                                                                      0xff4c5372),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        Text(
                                                          data.uv.toString(),
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        Text(
                                                          "Very high",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 2.h,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 2.h,
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Stack(
                                                      alignment:
                                                          const Alignment(0, 0),
                                                      children: [
                                                        Container(
                                                          height: 0.5.h,
                                                          width: 35.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                const LinearGradient(
                                                              colors: [
                                                                Colors.green,
                                                                Colors.yellow,
                                                                Colors
                                                                    .deepOrange,
                                                                Colors.red,
                                                                Colors.pink,
                                                              ],
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              2.h,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 0.5.h,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "sun Protection until",
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
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w100,
                                                                  )
                                                                : AppThemes
                                                                    .lightThemeData
                                                                    .textTheme
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w100,
                                                                  ),
                                                          ),
                                                          const TextSpan(
                                                              text: " 16:30"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                          // 2
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    const Icon(
                                                      CupertinoIcons.wind,
                                                      color: Color(0xff4c5372),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      "WIND",
                                                      style: (Provider.of<
                                                                      DarkMode_Provider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkMode_Model
                                                              .isDark)
                                                          ? AppThemes
                                                              .darkThemeData
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                              color: const Color(
                                                                  0xff4c5372),
                                                            )
                                                          : AppThemes
                                                              .lightThemeData
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                              color: const Color(
                                                                  0xff4c5372),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                (Provider.of<WindMode_Provider>(
                                                            context,
                                                            listen: false)
                                                        .windMode_Model
                                                        .isWind)
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          Text(
                                                            data.windSpeedInKPH
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
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        3.h,
                                                                  )
                                                                : AppThemes
                                                                    .lightThemeData
                                                                    .textTheme
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        3.h,
                                                                  ),
                                                          ),
                                                          Text(" KPH",
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
                                                                      .headlineLarge!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          2.h,
                                                                    )
                                                                  : AppThemes
                                                                      .lightThemeData
                                                                      .textTheme
                                                                      .headlineLarge!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          2.h,
                                                                    )),
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          Text(
                                                            data.windSpeedInMPH
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
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        3.h,
                                                                  )
                                                                : AppThemes
                                                                    .lightThemeData
                                                                    .textTheme
                                                                    .headlineLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        3.h,
                                                                  ),
                                                          ),
                                                          Text(" MPH",
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
                                                                      .headlineLarge!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          2.h,
                                                                    )
                                                                  : AppThemes
                                                                      .lightThemeData
                                                                      .textTheme
                                                                      .headlineLarge!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          2.h,
                                                                    )),
                                                        ],
                                                      ),
                                              ],
                                            )
                                      : (i >= 4)
                                          ? (i == 4)
                                              // 4
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        const Icon(
                                                          CupertinoIcons
                                                              .thermometer,
                                                          color:
                                                              Color(0xff4c5372),
                                                        ),
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                        Text(
                                                          "FEEELS LIKE",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: const Color(
                                                                      0xff4c5372),
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: const Color(
                                                                      0xff4c5372),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Spacer(
                                                          flex: 3,
                                                        ),
                                                        Text(
                                                          "37",
                                                          style: (Provider.of<
                                                                          DarkMode_Provider>(
                                                                      context)
                                                                  .darkMode_Model
                                                                  .isDark)
                                                              ? AppThemes
                                                                  .darkThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  fontSize: 3.h,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                        ),
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                        CircleAvatar(
                                                          radius: 0.5.h,
                                                          backgroundColor: (Provider
                                                                      .of<DarkMode_Provider>(
                                                                          context)
                                                                  .darkMode_Model
                                                                  .isDark)
                                                              ? Colors.white
                                                              : Colors.white,
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
                                                                        .black,
                                                          ),
                                                        ),
                                                        const Spacer(
                                                          flex: 3,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(1.5.h),
                                                      child: Text(
                                                        "Humidity is making it feel hotter.",
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
                                                                .headlineLarge!
                                                                .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                              )
                                                            : AppThemes
                                                                .lightThemeData
                                                                .textTheme
                                                                .headlineLarge!
                                                                .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              // 5
                                              : Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        const Icon(
                                                          CupertinoIcons
                                                              .hurricane,
                                                          color:
                                                              Color(0xff4c5372),
                                                        ),
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                        Text(
                                                          "HUMIDITY",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: const Color(
                                                                      0xff4c5372),
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: const Color(
                                                                      0xff4c5372),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        Text(
                                                          data.humidity
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                ),
                                                        ),
                                                        Text(
                                                          "%",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 3.h,
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(1.5.h),
                                                      child: Text(
                                                        "The dew point is 22 right now.",
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
                                                                .headlineLarge!
                                                                .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                              )
                                                            : AppThemes
                                                                .lightThemeData
                                                                .textTheme
                                                                .headlineLarge!
                                                                .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                          // 3
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    const Icon(
                                                      CupertinoIcons
                                                          .cloud_bolt_rain_fill,
                                                      color: Color(0xff4c5372),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      "RAINFALL",
                                                      style: (Provider.of<
                                                                      DarkMode_Provider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkMode_Model
                                                              .isDark)
                                                          ? AppThemes
                                                              .darkThemeData
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                              color: const Color(
                                                                  0xff4c5372),
                                                            )
                                                          : AppThemes
                                                              .lightThemeData
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                              color: const Color(
                                                                  0xff4c5372),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    Text(
                                                      "0 mm",
                                                      style: (Provider.of<
                                                                      DarkMode_Provider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkMode_Model
                                                              .isDark)
                                                          ? AppThemes
                                                              .darkThemeData
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 3.h,
                                                            )
                                                          : AppThemes
                                                              .lightThemeData
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 3.h,
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    Text(
                                                      "in last 24h",
                                                      style: (Provider.of<
                                                                      DarkMode_Provider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkMode_Model
                                                              .isDark)
                                                          ? AppThemes
                                                              .darkThemeData
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 2.h,
                                                            )
                                                          : AppThemes
                                                              .lightThemeData
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 2.h,
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(1.h),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "None expected in next",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                ),
                                                        ),
                                                        const TextSpan(
                                                            text: " 10 "),
                                                        TextSpan(
                                                          text: "days",
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
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                )
                                                              : AppThemes
                                                                  .lightThemeData
                                                                  .textTheme
                                                                  .headlineLarge!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                ),
              ),
      ),
    );
  }
}
