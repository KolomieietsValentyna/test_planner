import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_planner/features/tasks/data/tasks_storage.dart';
import 'package:test_planner/features/tasks/entity/task_model.dart';
import 'package:test_planner/features/tasks_filter/entity/filter_dto.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  final TasksStorage taskStorage = TasksStorage();

  void init() async {
    List<TaskModel> tasks = await taskStorage.read();

    emit(TasksSuccess(
      allTasks: [...tasks],
      displayedTasks: [...tasks],
      filterData: FilterDto(),
    ));
  }

  // Adding new task to device storage and update TasksList in application by changing state
  void addTask(TaskModel task) {
    if (state is TasksSuccess) {
      final List<TaskModel> allTasks = [
        ...(state as TasksSuccess).allTasks,
        task
      ];
      final List<TaskModel> displayedTasks = [...allTasks];

      taskStorage.write(allTasks);

      emit(TasksSuccess(
          allTasks: allTasks,
          displayedTasks: displayedTasks,
          filterData: (state as TasksSuccess).filterData));
    }
  }

  // Delete selected task from device storage and from TasksList
  void deleteTask(TaskModel task) {
    if (state is TasksSuccess) {
      final List<TaskModel> allTasks = [...(state as TasksSuccess).allTasks];
      allTasks.remove(task);
      final List<TaskModel> displayedTasks = [
        ...(state as TasksSuccess).displayedTasks
      ];
      displayedTasks.remove(task);

      taskStorage.write(allTasks);

      emit(TasksSuccess(
        allTasks: allTasks,
        displayedTasks: displayedTasks,
        filterData: (state as TasksSuccess).filterData,
      ));
    }
  }

  // Change selected task status in device storage and in TasksList
  void changeStatus(TaskModel task) {
    List<TaskModel> allTasks = [...(state as TasksSuccess).allTasks];
    for (int i = 0; i < allTasks.length; ++i) {
      if (allTasks[i].id == task.id) {
        allTasks[i] = task;
      }
    }
    List<TaskModel> displayedTasks = [
      ...(state as TasksSuccess).displayedTasks
    ];
    for (int i = 0; i < displayedTasks.length; ++i) {
      if (displayedTasks[i].id == task.id) {
        displayedTasks[i] = task;
      }
    }

    taskStorage.write(allTasks);

    emit(TasksSuccess(
      allTasks: allTasks,
      displayedTasks: displayedTasks,
      filterData: (state as TasksSuccess).filterData,
    ));
  }

  // When filter was set, filter tasks by defined parmeters and show it in
  // TasksList by changing state
  void filterTasks(FilterDto filterData) {
    emit(TasksSuccess(
      allTasks: (state as TasksSuccess).allTasks,
      displayedTasks: (state as TasksSuccess).displayedTasks,
      filterData: filterData,
    ));

    final List<TaskModel> displayedTasks = [...filter()];

    emit(TasksSuccess(
      displayedTasks: displayedTasks,
      allTasks: (state as TasksSuccess).allTasks,
      filterData: (state as TasksSuccess).filterData,
    ));
  }

  // Filter tasks by defined parmeters
  List<TaskModel> filter() {
    List<TaskModel> filteredList =
        (state as TasksSuccess).allTasks.where((element) {
      // Check if some category was selected
      final bool isCategoryNotSelect =
          (state as TasksSuccess).filterData.categories.isEmpty;

      // Check if filter data contains element category
      final bool isCategoryMatches = (state as TasksSuccess)
          .filterData
          .categories
          .contains(element.category);

      // Check whether the filter category is compatible with the element category
      final bool isFitCategory = isCategoryNotSelect || isCategoryMatches;

      // How many elements contains status in filter data
      final int statusLength = (state as TasksSuccess).filterData.status.length;

      // Check how many statuses was selected
      // If status filter data contains 2 elements ('done' and 'not done'), it is
      //needed to show elements with both statuses, and when none of it was
      //selected (statusLength = 0), it is also needed to show elements with both statuses
      final bool isStatusNotSelect = statusLength == 0 || statusLength == 2;

      // Check if status in filter data match element status
      final bool isStatusMatches = (element.isDone &&
              (state as TasksSuccess).filterData.status.contains('done')) ||
          (!element.isDone &&
              (state as TasksSuccess).filterData.status.contains('not done'));

      // Check whether the filter status is compatible with the element status
      final bool isFitStatus = isStatusNotSelect || isStatusMatches;

      // Check if element match with filter category and filter status
      return isFitCategory && isFitStatus;
    }).toList();
    return filteredList;
  }

  // Clear filter data
  void clearFilter() {
    emit(TasksSuccess(
      allTasks: (state as TasksSuccess).allTasks,
      filterData: FilterDto(),
      displayedTasks: [...(state as TasksSuccess).allTasks],
    ));
  }
}
