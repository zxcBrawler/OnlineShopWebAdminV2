import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';

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

  /// Generates a list of FlSpot objects representing occurrences for each day
  /// of the week based on the given [deliveryInfoList] and [typeDeliveryId].
  ///
  /// The function filters the [deliveryInfoList] based on the provided
  /// [typeDeliveryId] and considers only the dates within the current week.
  ///
  /// Returns a list of FlSpot objects where the x-axis represents the day of the
  /// week (0 to 6, where 0 is Monday and 6 is Sunday), and the y-axis represents
  /// the occurrences for each corresponding day.
  static List<FlSpot> generateFlSpotList(
      List<DeliveryInfoEntity> deliveryInfoList,
      {required int typeDeliveryId}) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Filter and map deliveryInfoList to get DateTime objects within the current week
    List<DateTime> dateTimeList = deliveryInfoList
        .where((info) =>
            info.typeDelivery!.id == typeDeliveryId &&
            DateTime.parse(info.order!.dateOrder!).isAfter(
              currentDate.subtract(
                Duration(days: currentDate.weekday),
              ),
            ))
        .map((info) => DateTime.parse(info.order!.dateOrder!))
        .toList();

    // Generate FlSpot objects for each day of the week
    return List.generate(7, (index) {
      // Calculate occurrences for the current day (1 to 7)
      int occurrences = dateTimeList
          .where((dateTime) => dateTime.weekday == (index + 1))
          .length;

      // Return FlSpot object with x-axis representing the day and
      // y-axis representing the occurrences
      return FlSpot(index.toDouble(), occurrences.toDouble());
    });
  }
}
