import 'package:geolocator/geolocator.dart';
import 'package:test_planner/features/weather/domain/weather_repository.dart';
import 'package:test_planner/features/weather/data/geolocation_service.dart';
import 'package:test_planner/features/weather/entity/weather_dto.dart';
import 'package:test_planner/resources/constants/reserved_geolocation.dart';

class WeatherService {

  Future<WeatherDto?> getWeather() async {
    late final double latitude;
    late final double longitude;

    // Get current geolocation to show weather in the region
    try {
      final Position position = await GeolocationService().getGeolocation();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (error) {
      // If access to geolocation is denied, weather in Odesa will be shown
      latitude = ReservedGeolocation.lat;
      longitude = ReservedGeolocation.lon;
    }

    return WeatherRepository().getWeather(lat: latitude, long: longitude);
  }
}
