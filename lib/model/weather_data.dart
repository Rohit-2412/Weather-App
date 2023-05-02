import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/model/weather_data_daily.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourlyData;
  final WeatherDataDaily? dailyData;

  WeatherData([this.current, this.hourlyData, this.dailyData]);

// function to fetch these values
  WeatherDataCurrent getCurrentWeather() => current!;

  WeatherDataHourly getHourlyWeather() => hourlyData!;

  WeatherDataDaily getDailyWeather() => dailyData!;
}
