import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown_container.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield_style.dart';

class BasicDropdown extends StatefulWidget {
  final String listTitle;
  final List<String>? dropdownData;
  final int? selectedIndex;
  final Function(int)? onIndexChanged;
  final bool isColorDropdown;
  final List<String>? colorDropdownData;

  const BasicDropdown({
    super.key,
    this.dropdownData,
    required this.listTitle,
    required this.selectedIndex,
    this.onIndexChanged,
    required this.isColorDropdown,
    this.colorDropdownData,
  });

  @override
  State<BasicDropdown> createState() => _BasicDropdownState();
}

class _BasicDropdownState extends State<BasicDropdown> {
  String? selectedValue;

  @override

  /// Initialize the state of the BasicDropdown widget.
  ///
  /// This method initializes the state of the widget by setting the
  /// [selectedValue] to the value of the dropdown data at the specified
  /// [selectedIndex].
  @override
  void initState() {
    // Call the superclass's initState() method.
    super.initState();
  }

  @override

  /// Builds the dropdown widget.
  ///
  /// This method is responsible for building the dropdown widget. It creates
  /// a column with a text widget displaying the list title and a dropdown
  /// container widget containing a DropdownButton2 widget.
  ///
  /// The method also handles the onChanged callback of the DropdownButton2
  /// widget, updating the selectedValue state and calling the onIndexChanged
  /// callback provided in the widget constructor.
  ///
  /// Parameters:
  /// - `context`: The build context of the widget.
  ///
  /// Returns:
  /// - A widget representing the built dropdown.
  Widget build(BuildContext context) {
    // Set the selected value to the value of the dropdown data at the
    // specified selected index.
    selectedValue = widget.dropdownData![widget.selectedIndex!];
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 100, right: 100),
      child: Column(
        children: [
          // Display the list title
          Text(widget.listTitle, style: basicTextFieldStyle()),
          // Build the dropdown container
          dropdownContainer(
            DropdownButton2(
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              isExpanded: true,
              style: const TextStyle(),
              // Display a hint if no value is selected
              hint: Text(
                'select ${widget.listTitle}',
                style: basicTextFieldStyle(),
              ),
              // Build the dropdown items
              items: widget.isColorDropdown == false
                  ? widget.dropdownData!
                      .toSet()
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            // Display the item value
                            child: Row(
                              children: [
                                Text(
                                  item,
                                  style: basicTextFieldStyle(),
                                ),
                              ],
                            ),
                          ))
                      .toList()
                  : widget.dropdownData!
                      .toSet()
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            // Display the item value
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.circle,
                                    color: Methods.getColorFromHex(widget
                                            .colorDropdownData![
                                        widget.dropdownData!.indexOf(item)]),
                                  ),
                                ),
                                Text(
                                  item,
                                  style: basicTextFieldStyle(),
                                ),
                              ],
                            ),
                          ))
                      .toList(),

              value: selectedValue,
              // Handle the onChanged callback
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                });

                // Call the onIndexChanged callback if provided
                if (widget.onIndexChanged != null) {
                  setState(() {
                    widget.onIndexChanged!(
                        widget.dropdownData!.indexOf(value as String));
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
