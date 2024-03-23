import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield_style.dart';

class BasicSearchBar extends StatefulWidget {
  final Function(String?) onChangedCallback;
  const BasicSearchBar({super.key, required this.onChangedCallback});

  @override
  State<BasicSearchBar> createState() => _BasicSearchBarState();
}

class _BasicSearchBarState extends State<BasicSearchBar> {
  final TextEditingController _searchEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        hintText: 'search...',
        textStyle: MaterialStatePropertyAll(
          basicTextFieldStyle(),
        ),
        shadowColor: MaterialStatePropertyAll(AppColors.darkWhite),
        controller: _searchEditingController,
        onChanged: widget.onChangedCallback,
        leading: const Icon(Icons.search),
      ),
    );
  }
}
