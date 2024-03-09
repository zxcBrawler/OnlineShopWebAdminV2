import 'package:flutter/material.dart';

/// A utility class containing static methods for common functionalities.
class Methods {
  /// Converts a hexadecimal color code to a Flutter Color object.
  ///
  /// The [hexColor] parameter represents the hexadecimal color code,
  /// and the function returns the corresponding Color object.
  static Color getColorFromHex(String hexColor) {
    // Remove the '#' symbol from the hexColor
    hexColor = hexColor.replaceAll("#", "");

    // If the hexColor length is 6, add 'FF' for full opacity
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    // Parse the hexadecimal color code and return the Color object
    return Color(int.parse(hexColor, radix: 16));
  }

  /// Retrieves the TextEditingController associated with a given field name.
  ///
  /// The [fieldControllerMap] parameter is a map containing field names as keys
  /// and corresponding TextEditingController instances as values.
  /// The [fieldName] parameter specifies the desired field name.
  ///
  /// Throws an exception if the field name is not found in the map.
  static TextEditingController getControllerForField(
      Map<String, TextEditingController> fieldControllerMap, String fieldName) {
    // Check if the field name is present in the map
    if (fieldControllerMap.containsKey(fieldName)) {
      // Return the associated TextEditingController
      return fieldControllerMap[fieldName]!;
    } else {
      // Throw an exception for an invalid field name
      throw Exception("Invalid field: $fieldName");
    }
  }
}
