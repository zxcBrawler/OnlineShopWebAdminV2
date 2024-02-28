import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield_style.dart';

class BasicSearchBar extends StatefulWidget {
  const BasicSearchBar({super.key});

  @override
  State<BasicSearchBar> createState() => _BasicSearchBarState();
}

class _BasicSearchBarState extends State<BasicSearchBar> {
  final TextEditingController _searchEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchBar(
          textStyle: MaterialStatePropertyAll(
            basicTextFieldStyle(),
          ),
          shadowColor: MaterialStatePropertyAll(AppColors.darkWhite),
          controller: _searchEditingController,
          onChanged: (String value) {
            setState(() {
              _searchEditingController.text == value;
            });
          },
          leading: const Icon(Icons.search),
          trailing: _searchEditingController.text.isNotEmpty
              ? [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _searchEditingController.clear();
                        });
                      },
                      icon: const Icon(Icons.close))
                ]
              : null,
        ),
      ),
    );
  }
}
