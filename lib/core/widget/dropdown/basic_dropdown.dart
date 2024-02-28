import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown_container.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield_style.dart';

class BasicDropdown extends StatefulWidget {
  final String listTitle;
  final List<String> dropdownData;
  final int selectedIndex;
  const BasicDropdown(
      {super.key,
      required this.dropdownData,
      required this.listTitle,
      required this.selectedIndex});

  @override
  State<BasicDropdown> createState() => _BasicDropdownState();
}

class _BasicDropdownState extends State<BasicDropdown> {
  String? selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.dropdownData[widget.selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 100, right: 100),
      child: Column(
        children: [
          Text(widget.listTitle, style: basicTextFieldStyle()),
          dropdownContainer(
            DropdownButton2(
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              isExpanded: true,
              style: const TextStyle(),
              hint: Text(
                'select ${widget.listTitle}',
                style: basicTextFieldStyle(),
              ),
              items: widget.dropdownData
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: basicTextFieldStyle(),
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
