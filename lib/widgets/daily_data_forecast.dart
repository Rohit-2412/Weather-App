import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/model/weather_data_daily.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForecast({super.key, required this.weatherDataDaily});

// get date from timestamp
  getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final temp = DateFormat("EEE").format(time);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text(
              "Weekly Forecast",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: CustomColors.textColorBlack,
              ),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    var totalLength = weatherDataDaily.daily.length;
    return SizedBox(
      height: 450,
      child: ListView.builder(
        // making list static
        controller: ScrollController(keepScrollOffset: false),
        scrollDirection: Axis.vertical,
        itemCount: totalLength > 7 ? 7 : totalLength,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      // height: 30,
                      width: 50,
                      child: Text(
                        getDay(weatherDataDaily.daily[index].dt),
                        style: const TextStyle(
                            color: CustomColors.textColorBlack, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Image.asset(
                            "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png"),
                      ),
                    ),
                    SizedBox(
                      // width: 60,
                      // height: 30,
                      child: Text(
                        "${weatherDataDaily.daily[index].temp!.max}° / ${weatherDataDaily.daily[index].temp!.min}°",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: CustomColors.textColorBlack, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              index == totalLength - 2
                  ? Container()
                  : Container(height: 2, color: CustomColors.dividerLine)
            ],
          );
        },
      ),
    );
  }
}
