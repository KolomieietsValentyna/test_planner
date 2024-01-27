import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:test_planner/features/weather/data/weather_api.dart';
import 'package:test_planner/features/weather/entity/weather_dto.dart';

class WeatherRepository {
  final WeatherApi api = WeatherApi();

  Future<WeatherDto?> getWeather({
    required double lat,
    required double long,
  }) async {
    // Check is internet connection is ok
    bool isConnected = await isInternetConnected();
    if (!isConnected) return null;

    // Get weather data from api and create DTO to return the data
    Response response = await api.weatherRequest(lat: '$lat', long: '$long');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data['current'];
        WeatherDto weather = WeatherDto(
          temperature: '${data['temp']}',
          humidity: '${data['humidity']}',
          windSpeed: '${data['wind_speed']}',
          description: '${data['weather'][0]['description']}',
          feelsLike: '${data['feels_like']}',
        );
        return weather;
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<bool> isInternetConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) return false;
    return true;
  }
}
