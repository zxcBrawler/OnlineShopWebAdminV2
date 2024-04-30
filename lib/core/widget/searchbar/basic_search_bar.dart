import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield_style.dart';
import 'package:xc_web_admin/generated/l10n.dart';

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

  /// Builds the [SearchBar] widget and returns it.
  ///
  /// This method is called when the [State]'s [build] method is invoked.
  /// It returns a [Padding] widget that wraps a [SearchBar] widget.
  ///
  /// The [SearchBar] widget is configured with various properties like
  /// [hintText], [textStyle], [shadowColor], [controller], [onChanged], and [leading].
  /// The [hintText] is set to 'search...', [textStyle] is set to a
  /// [MaterialStatePropertyAll] with [basicTextFieldStyle], [shadowColor]
  /// is set to [MaterialStatePropertyAll] with [AppColors.darkWhite],
  /// [controller] is set to [_searchEditingController], [onChanged] is set
  /// to [widget.onChangedCallback], and [leading] is set to [const Icon(Icons.search)].
  ///
  /// Parameters:
  /// - [context]: The [BuildContext] in which this widget is being built.
  ///
  /// Returns:
  /// - A [Padding] widget that wraps a [SearchBar] widget.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        hintText: S.current.search, // Hint text for the search bar
        textStyle: MaterialStatePropertyAll(
          basicTextFieldStyle(), // Text style for the search bar
        ),
        shadowColor: MaterialStatePropertyAll(
            AppColors.darkWhite), // Shadow color for the search bar
        controller:
            _searchEditingController, // The text editing controller for the search bar
        onChanged: widget
            .onChangedCallback, // Callback for when the text in the search bar changes
        leading: const Icon(
            Icons.search), // Leading widget (an icon) for the search bar
      ),
    );
  }
}
