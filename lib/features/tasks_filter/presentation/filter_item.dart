import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  final String title;
  final bool checkbox;
  final void Function(String) changeCheckbox;
  
  const FilterItem({
    required this.title,
    required this.checkbox,
    required this.changeCheckbox,
    super.key,
  });

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  late bool checkBox;

  @override
  void initState() {
    checkBox = widget.checkbox;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        Checkbox(
          value: checkBox,
          onChanged: (bool? value) {
            widget.changeCheckbox(widget.title);
            checkBox = value!;
            
            setState(() {});
          },
        ),
      ],
    );
  }
}
