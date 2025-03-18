part of 'task_cubit.dart';

sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TasksSuccess extends TaskState {
  final List<TaskModel> allTasks;
  final List<TaskModel> displayedTasks;
  final FilterDto filterData;

  TasksSuccess({
    required this.allTasks,
    required this.displayedTasks,
    required this.filterData,
  });

  TasksSuccess copyWith({
    List<TaskModel>? allTasks,
    List<TaskModel>? displayedTasks,
    FilterDto? filterData,
  }) {
    return TasksSuccess(
      allTasks: allTasks ?? this.allTasks,
      displayedTasks: displayedTasks ?? this.displayedTasks,
      filterData: filterData ?? this.filterData,
    );
  }
}
