import 'package:flutter/material.dart';
import 'package:test_planner/common/widget/dialog_layout.dart';
import 'package:test_planner/features/weather/domain/weather_service.dart';
import 'package:test_planner/features/weather/entity/weather_dto.dart';

class WeatherDialog extends StatefulWidget {
  const WeatherDialog({super.key});

  @override
  State<WeatherDialog> createState() => _WeatherDialogState();
}

class _WeatherDialogState extends State<WeatherDialog> {
  WeatherDto? weather;

  @override
  Widget build(BuildContext context) {
    return DialogLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
          FutureBuilder(
            future: getApiData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (weather == null) {
                  return const Text(
                    'Oops some problem with internet connection...',
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Temperature: ${weather!.temperature}ºC'),
                    Text('Feels like: ${weather!.feelsLike}ºC'),
                    Text('Humidity ${weather!.humidity}%'),
                    Text('Wind speed: ${weather!.windSpeed} metre/sec'),
                    Text('Description: ${weather!.description}'),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Future<void> getApiData() async {
    weather = await WeatherService().getWeather();
  }
}
