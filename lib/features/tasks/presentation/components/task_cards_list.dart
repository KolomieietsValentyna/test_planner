import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_planner/features/tasks/presentation/components/task_card.dart';
import 'package:test_planner/features/tasks/domain/tasks_bloc/tasks_bloc.dart';
import 'package:test_planner/resources/style/app_sizes.dart';

class TaskCardsList extends StatelessWidget {
  const TaskCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TasksBloc, TasksState>(
        buildWhen: (previous, current) {
          return previous.displayedTasks != current.displayedTasks;
        },
        builder: (context, state) {
          // If some tasks were created show list with tasks
          if (state.displayedTasks.isNotEmpty) {
            final tasks = state.displayedTasks;

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.s8,
                horizontal: AppSizes.s16,
              ),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  task: tasks[index],
                  key: UniqueKey(),
                );
              },
            );
          } else {
            // If no tasks were created show this text
            return const Center(
              child: Text('You have no tasks'),
            );
          }
        },
      ),
    );
  }
}
