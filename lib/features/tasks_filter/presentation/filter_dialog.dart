import 'package:flutter/material.dart';
import 'package:test_planner/common/widget/dialog_layout.dart';
import 'package:test_planner/features/tasks_filter/presentation/filter_item.dart';
import 'package:test_planner/common/widget/app_button.dart';
import 'package:test_planner/features/tasks/domain/tasks_bloc/tasks_bloc.dart';
import 'package:test_planner/features/tasks_filter/presentation/mixins/filter_dialog_mixin.dart';
import 'package:test_planner/resources/style/app_colors.dart';
import 'package:test_planner/resources/style/app_sizes.dart';

class FilterDialog extends StatefulWidget {
  final TasksBloc bloc;
  
  const FilterDialog({required this.bloc, super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> with FilterDialogMixin {
  @override
  Widget build(BuildContext context) {
    return DialogLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Categories'),
          FilterItem(
            title: 'Home',
            checkbox: isHome,
            changeCheckbox: changeCheckbox,
          ),
          FilterItem(
            title: 'Work',
            checkbox: isWork,
            changeCheckbox: changeCheckbox,
          ),
          FilterItem(
            title: 'Personal',
            checkbox: isPersonal,
            changeCheckbox: changeCheckbox,
          ),
          const Text('Status'),
          FilterItem(
            title: 'done',
            checkbox: isDone,
            changeCheckbox: changeCheckbox,
          ),
          FilterItem(
            title: 'not done',
            checkbox: isNotDone,
            changeCheckbox: changeCheckbox,
          ),
          const SizedBox(height: AppSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppButton(
                title: 'Clear filter',
                color: AppColors.grey,
                onTap: clearFilter,
              ),
              AppButton(
                title: 'Save',
                color: AppColors.blueAccent,
                onTap: saveFilters,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
