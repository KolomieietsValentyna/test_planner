part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class InitEvent extends TasksEvent {
  InitEvent();
}

class AddTaskEvent extends TasksEvent {
  final TaskModel task;
  AddTaskEvent({required this.task});
}

class DeleteTaskEvent extends TasksEvent {
  final TaskModel task;
  DeleteTaskEvent({required this.task});
}

class ChangeStatusTaskEvent extends TasksEvent {
  final TaskModel task;
  ChangeStatusTaskEvent({required this.task});
}

class SetFilterEvent extends TasksEvent {
  final FilterDto filterData;
  SetFilterEvent({required this.filterData});
}

class ClearFilterEvent extends TasksEvent {
  ClearFilterEvent();
}