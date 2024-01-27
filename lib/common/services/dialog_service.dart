import 'package:flutter/material.dart';

class DialogService {
  static DialogService? _instance;
  
  factory DialogService() {
    return _instance ??= DialogService._privatConstructor();
  }
  DialogService._privatConstructor();

  void show(BuildContext context, Widget child) {
    showDialog(context: context, builder: (context) => child);
  }
}
