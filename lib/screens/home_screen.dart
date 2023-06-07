import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';
import 'package:weatherapp_starter_project/widgets/comfort_level.dart';
import 'package:weatherapp_starter_project/widgets/current_weather_widget.dart';
import 'package:weatherapp_starter_project/widgets/daily_data_forecast.dart';
import 'package:weatherapp_starter_project/widgets/header_widget.dart';
import 'package:weatherapp_starter_project/widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Weather App",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[500],
                    ),
                  ),
                  const SizedBox(height: 100),
                  Image.asset('assets/icons/clouds.png'),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator()
                ],
              ))
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    const HeaderWidget(),

                    // for current temperature ('current')
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          globalController.getData().getCurrentWeather(),
                    ),

                    const SizedBox(height: 20),

                    // hourly basis data ('hourly')
                    HourlyDataWidget(
                      weatherDataHourly:
                          globalController.getData().getHourlyWeather(),
                    ),

                    // daily data forecast ('daily')
                    DailyDataForecast(
                      weatherDataDaily:
                          globalController.getData().getDailyWeather(),
                    ),

                    // slider and other widgets
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: CustomColors.dividerLine,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    ComfortLevel(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather()),
                  ],
                ),
              )),
      ),
    );
  }
}
