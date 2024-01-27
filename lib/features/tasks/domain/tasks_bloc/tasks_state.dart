part of 'tasks_bloc.dart';

class TasksState {
  final List<TaskModel> allTasks;
  final List<TaskModel> displayedTasks;
  final FilterDto filterData;

  const TasksState({
    required this.allTasks,
    required this.displayedTasks,
    required this.filterData,
  });

  TasksState copyWith({
    List<TaskModel>? allTasks,
    List<TaskModel>? displayedTasks,
    FilterDto? filterData,
  }) {
    return TasksState(
      allTasks: allTasks ?? this.allTasks,
      displayedTasks: displayedTasks ?? this.displayedTasks,
      filterData: filterData ?? this.filterData,
    );
  }
}
