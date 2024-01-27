import 'package:flutter/material.dart';
import 'package:test_planner/resources/style/app_colors.dart';
import 'package:test_planner/resources/style/app_sizes.dart';

class DialogLayout extends StatelessWidget {
  final Widget child;

  const DialogLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.s16),
            margin: const EdgeInsets.all(AppSizes.s16),
            color: AppColors.white,
            child: child,
          ),
        ),
      ),
    );
  }
}
