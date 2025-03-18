import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_planner/features/tasks/domain/task_cubit/task_cubit.dart';
import 'package:test_planner/features/tasks/entity/task_model.dart';
import 'package:test_planner/resources/style/app_colors.dart';
import 'package:test_planner/resources/style/app_sizes.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;

  const TaskCard({required this.task, super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool checkBox;

  @override
  void initState() {
    checkBox = widget.task.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.s16),
      margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.3),
            blurRadius: 2.0,
            blurStyle: BlurStyle.outer,
          )
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: checkBox,
                onChanged: (bool? value) {
                  // Change task status and send this information to TasksBloc
                  // to rewrite it in device storage
                  checkBox = value!;
                  widget.task.changeStatus();
                  context.read<TaskCubit>().changeStatus(widget.task);
                },
              ),
              Flexible(
                child: Text(
                  widget.task.title,
                  overflow: TextOverflow.fade,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: AppColors.red),
                onPressed: () {
                  // Delete task with adding DeleteTaskEvent to TasksBloc
                  context.read<TaskCubit>().deleteTask(widget.task);
                },
              )
            ],
          ),
          const SizedBox(height: AppSizes.s8),
          Text(widget.task.description),
        ],
      ),
    );
  }
}
