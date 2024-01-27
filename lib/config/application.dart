import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_planner/features/tasks/presentation/my_home_screen.dart';
import 'package:test_planner/features/tasks/domain/tasks_bloc/tasks_bloc.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create bloc and call InitEvent to get information about tasks from the 
      // internal memory of the device
      create: (context) => TasksBloc()..add(InitEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test Planner',
        home: MyHomeScreen(),
      ),
    );
  }
}
