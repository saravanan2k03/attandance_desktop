import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final String? hintText;
  final List<String>? dropDownMenu;
  final String? selectedItem;
  final Function(String?)? onChanged;
  const MyDropdown({
    super.key,
    this.hintText,
    this.dropDownMenu,
    this.selectedItem,
    this.onChanged,
  });

  @override
  MyDropdownState createState() => MyDropdownState();
}

class MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value:
          (widget.dropDownMenu?.contains(widget.selectedItem) ?? false)
              ? widget.selectedItem
              : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(),
        labelText: widget.hintText ?? "",
      ),
      items:
          widget.dropDownMenu?.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  value,
                  softWrap: true,
                  maxLines: 3, // wrap into multiple lines
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
