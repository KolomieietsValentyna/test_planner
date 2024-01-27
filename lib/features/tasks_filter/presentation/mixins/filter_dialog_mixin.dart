import 'package:flutter/material.dart';
import 'package:test_planner/features/tasks/domain/tasks_bloc/tasks_bloc.dart';
import 'package:test_planner/features/tasks_filter/entity/filter_dto.dart';
import 'package:test_planner/features/tasks_filter/presentation/filter_dialog.dart';

mixin FilterDialogMixin<T extends StatefulWidget> on State<FilterDialog> {
  late FilterDto filter;
  bool isHome = false;
  bool isWork = false;
  bool isPersonal = false;
  bool isDone = false;
  bool isNotDone = false;

  @override
  void initState() {
    super.initState();
    filter = widget.bloc.state.filterData;
    setFilter();
  }

  // Function to pass current data to TasksBloc for filtering
  void saveFilters() {
    widget.bloc.add(SetFilterEvent(filterData: getFilter()));
    Navigator.of(context).pop();
  }

  // Clear all filter data and close pop-up
  void clearFilter() {
    widget.bloc.add(ClearFilterEvent());
    Navigator.of(context).pop();
  }

  // Calls every time when filter pop-up open to check if some filter have been already set
  // If there are some filters set, changes corresponding checkboxes to true
  void setFilter() {
    if (filter.categories.isNotEmpty) {
      for (int i = 0; i < filter.categories.length; i++) {
        switch (filter.categories[i]) {
          case 'Home':
            isHome = true;
            break;
          case 'Work':
            isWork = true;
            break;
          case 'Personal':
            isPersonal = true;
            break;
        }
      }
    }
    if (filter.status.isNotEmpty) {
      for (int i = 0; i < filter.status.length; i++) {
        switch (filter.status[i]) {
          case 'done':
            isDone = true;
            break;
          case 'not done':
            isNotDone = true;
            break;
        }
      }
    }
  }

  // Change checkboxes state if they were pushed
  void changeCheckbox(String title) {
    switch (title) {
      case 'Home':
        isHome = !isHome;
        break;
      case 'Work':
        isWork = !isWork;
        break;
      case 'Personal':
        isPersonal = !isPersonal;
        break;
      case 'done':
        isDone = !isDone;
        break;
      case 'not done':
        isNotDone = !isNotDone;
        break;
    }
  }

  // Save status and categories of filter and create DTO for further use in SetFilterEvent
  FilterDto getFilter() {
    List<String> categories = [];
    List<String> status = [];
    if (isHome) categories.add('Home');
    if (isWork) categories.add('Work');
    if (isPersonal) categories.add('Personal');
    if (isDone) status.add('done');
    if (isNotDone) status.add('not done');

    return FilterDto(categories: categories, status: status);
  }
}
