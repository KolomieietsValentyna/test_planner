import 'package:dio/dio.dart';

class WeatherApi {
  late final Dio _dio;

  WeatherApi() {
    _dio = Dio();
  }

  // Request to third party service with registered ApiKey and current location
  Future<Response<dynamic>> weatherRequest({
    required String lat,
    required String long,
  }) async {
    return await _dio.get(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&units=metric&appid=e9dd99667600e8f5d6084ec782b77bdf');
  }
}
