import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_planner/features/tasks/entity/task_model.dart';
import 'package:test_planner/features/tasks_filter/entity/filter_dto.dart';
import 'package:test_planner/features/tasks/data/tasks_storage.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc()
      : super(TasksState(
          allTasks: [],
          displayedTasks: [],
          filterData: FilterDto(),
        )) {
    on<InitEvent>(_init);
    on<AddTaskEvent>(_addTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<ChangeStatusTaskEvent>(_changeStatus);
    on<SetFilterEvent>(_filterTasks);
    on<ClearFilterEvent>(_clearFilter);
  }

  final TasksStorage taskStorage = TasksStorage();

  // In the beginning of the app get information about created tasks
  // to show this information on the HomeScreen
  void _init(InitEvent event, Emitter<TasksState> emit) async {
    List<TaskModel> tasks = await taskStorage.read();

    emit(state.copyWith(
      allTasks: [...tasks],
      displayedTasks: [...tasks],
    ));
  }

  // Adding new task to device storage and update TasksList in application by changing state
  void _addTask(AddTaskEvent event, Emitter<TasksState> emit) {
    final List<TaskModel> allTasks = [...state.allTasks, event.task];
    final List<TaskModel> displayedTasks = [...allTasks];

    taskStorage.write(allTasks);

    emit(state.copyWith(
      allTasks: allTasks,
      displayedTasks: displayedTasks,
    ));
  }

  // Delete selected task from device storage and from TasksList
  void _deleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) {
    final List<TaskModel> allTasks = [...state.allTasks];
    allTasks.remove(event.task);
    final List<TaskModel> displayedTasks = [...state.displayedTasks];
    displayedTasks.remove(event.task);

    taskStorage.write(allTasks);

    emit(state.copyWith(
      allTasks: allTasks,
      displayedTasks: displayedTasks,
    ));
  }

  // Change selected task status in device storage and in TasksList
  void _changeStatus(
    ChangeStatusTaskEvent event,
    Emitter<TasksState> emit,
  ) {
    List<TaskModel> allTasks = [...state.allTasks];
    for (int i = 0; i < allTasks.length; ++i) {
      if (allTasks[i].id == event.task.id) {
        allTasks[i] = event.task;
      }
    }
    List<TaskModel> displayedTasks = [...state.displayedTasks];
    for (int i = 0; i < displayedTasks.length; ++i) {
      if (displayedTasks[i].id == event.task.id) {
        displayedTasks[i] = event.task;
      }
    }

    taskStorage.write(allTasks);

    emit(state.copyWith(
      allTasks: allTasks,
      displayedTasks: displayedTasks,
    ));
  }

  // When filter was set, filter tasks by defined parmeters and show it in 
  // TasksList by changing state
  void _filterTasks(SetFilterEvent event, Emitter<TasksState> emit) {
    emit(state.copyWith(filterData: event.filterData));

    final List<TaskModel> displayedTasks = [..._filter()];
    
    emit(state.copyWith(displayedTasks: displayedTasks));
  }

  // Filter tasks by defined parmeters
  List<TaskModel> _filter() {
    List<TaskModel> filteredList = state.allTasks.where((element) {
      // Check if some category was selected
      final bool isCategoryNotSelect = state.filterData.categories.isEmpty;
      // Check if filter data contains element category
      final bool isCategoryMatches =
          state.filterData.categories.contains(element.category);
      // Check whether the filter category is compatible with the element category
      final bool isFitCategory = isCategoryNotSelect || isCategoryMatches;

      // How many elements contains status in filter data
      final int statusLength = state.filterData.status.length;
      // Check how many statuses was selected
      // If status filter data contains 2 elements ('done' and 'not done'), it is 
      //needed to show elements with both statuses, and when none of it was 
      //selected (statusLength = 0), it is also needed to show elements with both statuses
      final bool isStatusNotSelect =
          statusLength == 0 || statusLength == 2;
      // Check if status in filter data match element status
      final bool isStatusMatches =
          (element.isDone && state.filterData.status.contains('done')) ||
              (!element.isDone && state.filterData.status.contains('not done'));
      // Check whether the filter status is compatible with the element status
      final bool isFitStatus = isStatusNotSelect || isStatusMatches;

      // Check if element match with filter category and filter status
      return isFitCategory && isFitStatus;
    }).toList();
    return filteredList;
  }

  // Clear filter data
  void _clearFilter(ClearFilterEvent event, Emitter<TasksState> emit) {
    emit(state.copyWith(
      filterData: FilterDto(),
      displayedTasks: [...state.allTasks],
    ));
  }
}
