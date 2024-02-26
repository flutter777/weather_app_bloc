import 'dart:convert';

import 'package:http/http.dart' as http;

// import '../constants/secrets.dart'
import '../exceptions/weather_exception.dart';
import '../models/weather.dart';
import 'http_error_handler.dart';

class WeatherApiServices {
  Future<Weather> getWeather(String city) async {
    String apiKey = '6d86155610dd567d3ff014bcfbc1522b';
    String City = city; // Example city
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=City&appid=${apiKey}';

    // final Uri uri = Uri(
    //   scheme: 'https',
    //   host: 'kHostApi',
    //   path: '/data/2.5/weather',
    //   queryParameters: {
    //     'q': city,
    //     'appid': 'd2142e5575fbf3276c1db2da5c75760d',
    //   },
    // );



    try {
      final response = await http.get(Uri.parse(apiUrl.replaceFirst('City', City)));
      print('the response is ${response.body}');

      // final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      } else {
        late final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw WeatherException('Cannot get the weather of the city');
        }

        return Weather.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }
}
