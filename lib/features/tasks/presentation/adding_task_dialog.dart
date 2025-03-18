import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_planner/common/widget/dialog_layout.dart';
import 'package:test_planner/common/widget/app_button.dart';
import 'package:test_planner/features/tasks/domain/task_cubit/task_cubit.dart';
import 'package:test_planner/features/tasks/entity/task_model.dart';
import 'package:test_planner/resources/constants/filter_data.dart';
import 'package:test_planner/resources/style/app_colors.dart';
import 'package:test_planner/resources/style/app_sizes.dart';

class AddingTaskDialog extends StatefulWidget {
  const AddingTaskDialog({super.key});

  @override
  State<AddingTaskDialog> createState() => _AddingTaskDialogState();
}

class _AddingTaskDialogState extends State<AddingTaskDialog> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  String? dropdownValue;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextFormField(
            minLines: 1,
            maxLines: 5,
            controller: descriptionController,
            decoration: const InputDecoration(
              label: Text('Description'),
            ),
          ),
          const SizedBox(height: AppSizes.s16),

          // Show dropdown with tasks category
          DropdownButton<String>(
            value: dropdownValue,
            hint: const Text('Choose category'),
            underline: Container(color: AppColors.grey, height: AppSizes.s1),
            isExpanded: true,
            onChanged: (String? value) {
              dropdownValue = value!;
              setState(() {});
            },
            items: FilterData.categories.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
          const SizedBox(height: AppSizes.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppButton(
                color: AppColors.grey,
                title: 'Cancel',
                onTap: () => Navigator.of(context).pop(),
              ),
              AppButton(
                title: 'Save',
                color: AppColors.blueAccent,
                onTap: () {
                  // Check if task is not empty
                  if (titleController.text != '' ||
                      descriptionController.text != '') {
                    context.read<TaskCubit>().addTask(
                          TaskModel(
                            id: DateTime.now().toString(),
                            title: titleController.text,
                            description: descriptionController.text,
                            category: dropdownValue ?? '',
                          ),
                        );
                  }

                  // Close addTask pop-up
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
