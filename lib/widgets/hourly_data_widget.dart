import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';

// ignore: must_be_immutable
class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({super.key, required this.weatherDataHourly});

  RxInt cardIndex = GlobalController().getIndex();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.center,
          child: const Text(
            "Today",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // if item count exceeds 12, then show only 12 items
        itemCount: weatherDataHourly.hourly.length > 12
            ? 12
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 15, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0.5, 0),
                        blurRadius: 30,
                        color: CustomColors.dividerLine.withAlpha(150),
                        spreadRadius: 1,
                      )
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(
                            colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor
                            ],
                          )
                        : null,
                  ),
                  child: HourlyDetails(
                    temp: weatherDataHourly.hourly[index].temp!,
                    index: index,
                    cardIndex: cardIndex.toInt(),
                    timestamp: weatherDataHourly.hourly[index].dt!,
                    icon: weatherDataHourly.hourly[index].weather![0].icon!,
                  ),
                ),
              ));
        },
      ),
    );
  }
}

// hourly details class
// ignore: must_be_immutable
class HourlyDetails extends StatelessWidget {
  int temp;
  int timestamp;
  String icon;
  int index, cardIndex;
  HourlyDetails(
      {super.key,
      required this.temp,
      required this.index,
      required this.cardIndex,
      required this.timestamp,
      required this.icon});

  String getTime(timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    String dateTime = DateFormat("jm").format(time);

    return dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timestamp),
            style: TextStyle(
                color: cardIndex == index ? Colors.white : Colors.black),
          ),
        ),
        Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.all(5),
          child: Image.asset("assets/weather/$icon.png"),
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              "$temp°",
              style: TextStyle(
                  fontSize: 18,
                  color: index == cardIndex
                      ? Colors.white
                      : CustomColors.textColorBlack),
            ))
      ],
    );
  }
}
