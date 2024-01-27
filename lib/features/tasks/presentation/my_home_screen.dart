import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_planner/common/services/dialog_service.dart';
import 'package:test_planner/features/tasks/presentation/adding_task_dialog.dart';
import 'package:test_planner/features/tasks_filter/presentation/filter_dialog.dart';
import 'package:test_planner/features/tasks/presentation/components/task_cards_list.dart';
import 'package:test_planner/features/tasks/domain/tasks_bloc/tasks_bloc.dart';
import 'package:test_planner/features/weather/presentation/weather_dialog.dart';
import 'package:test_planner/common/widget/app_button.dart';
import 'package:test_planner/resources/style/app_colors.dart';
import 'package:test_planner/resources/style/app_sizes.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  bool isFilter = false;
  dynamic weather;
  Position? position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt, color: AppColors.white),
            onPressed: () {
              DialogService().show(
                context,
                FilterDialog(bloc: BlocProvider.of<TasksBloc>(context)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: AppSizes.s16),
          AppButton(
            title: 'Show current weather',
            color: AppColors.blueAccent,
            onTap: () {
              DialogService().show(context, const WeatherDialog());
            },
          ),
          const TaskCardsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          DialogService().show(context, const AddingTaskDialog());
        },
      ),
    );
  }
}
