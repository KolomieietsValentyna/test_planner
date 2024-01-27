class WeatherDto {
  final String temperature;
  final String feelsLike;
  final String humidity;
  final String windSpeed;
  final String description;

  WeatherDto({
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.temperature,
    required this.windSpeed,
  });
}
