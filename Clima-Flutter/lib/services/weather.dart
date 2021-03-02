import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = 'ad838b52428d99d1d20e61c020d4fc09';

class WeatherModel {
  Future<dynamic> getCityWeather(String city) async {
    var weatherData = await NetworkHelper(
      '$openWeatherMapURL?q=$city&appid=$apiKey&units=metric',
    ).getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    var weatherData = await NetworkHelper(
      '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    ).getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
