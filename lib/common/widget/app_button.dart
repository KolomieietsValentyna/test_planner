import 'package:flutter/material.dart';
import 'package:test_planner/resources/style/app_colors.dart';
import 'package:test_planner/resources/style/app_sizes.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onTap;

  const AppButton({
    required this.color,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.s8),
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.3),
              blurRadius: 2.0,
              blurStyle: BlurStyle.outer,
            )
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
