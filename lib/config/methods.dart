import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/text/card_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_state.dart';

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

  static List<BarChartRodData> generateFlSpotListForOrdersComp(
      List<OrderCompositionEntity> orderCompList,
      {required int genderId}) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Group compositions by date and calculate the total quantity for each date
    Map<DateTime, int> soldItemsByDate = {};
    for (var composition in orderCompList) {
      if (composition.clothesComp!.typeClothes!.categoryClothes!.id! !=
          genderId) {
        continue; // Skip compositions that don't match the specified gender
      }
      DateTime compositionDate =
          DateTime.parse(composition.orderId!.dateOrder!);
      DateTime dateKey = DateTime(
          compositionDate.year, compositionDate.month, compositionDate.day);
      int quantity = composition.quantity ?? 0;
      soldItemsByDate.update(dateKey, (value) => value + quantity,
          ifAbsent: () => quantity);
    }

    // Generate BarChartRodData objects for each day of the week
    return List.generate(7, (index) {
      // Calculate the date for the current day of the week
      DateTime currentDay =
          currentDate.subtract(Duration(days: currentDate.weekday - index));
      DateTime dayKey =
          DateTime(currentDay.year, currentDay.month, currentDay.day);
      int itemsSold = soldItemsByDate[dayKey] ?? 0;

      // Return BarChartRodData object with x-axis representing the day and
      // y-axis representing the total items sold
      return BarChartRodData(toY: itemsSold.toDouble());
    });
  }

  static String displayCurrentWeek() {
    DateTime currentDate = DateTime.now();
    DateTime startDate =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    DateTime endDate = startDate.add(const Duration(days: 6));
    String currentWeek =
        'Week of ${startDate.year}/${startDate.month}/${startDate.day} - ${endDate.year}/${endDate.month}/${endDate.day}';
    return currentWeek;
  }

  /// Widget that builds a list of order compositions for each date within a
  /// week, and groups them by date.
  ///
  /// The function first finds the start and end of the week, then filters the
  /// list of order compositions to include only those within the week. It
  /// then groups the compositions by date and sorts the entries by date.
  /// Finally, it builds a ListView.builder widget to display each date and its
  /// corresponding list of order compositions.
  ///
  /// Parameters:
  ///   - [state]: The state containing the list of order compositions.
  ///   - [isMobile]: Whether the app is running on a mobile device.
  static Widget buildWeeklyOrdersCompositions(
      RemoteOrderCompState state, bool isMobile, compositions) {
    // List of order compositions for the week

    // Start and end of the week
    DateTime startOfWeek = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // Filter compositions to include only those within the week
    List<OrderCompositionEntity> weeklyCompositions = compositions.where(
      (composition) {
        DateTime compositionDate =
            DateTime.parse(composition.orderId!.dateOrder!);
        return compositionDate
                .isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            compositionDate.isBefore(endOfWeek);
      },
    ).toList();

    // Group compositions by date
    Map<DateTime, List<OrderCompositionEntity>> groupedCompositions = groupBy(
        weeklyCompositions,
        (composition) => DateTime.parse(composition.orderId!.dateOrder!));

    // Sort entries by date
    List<MapEntry<DateTime, List<OrderCompositionEntity>>> sortedEntries =
        groupedCompositions.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));

    // Build ListView.builder widget to display each date and its list of
    // order compositions
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: sortedEntries.length,
        itemBuilder: (context, index) {
          MapEntry<DateTime, List<OrderCompositionEntity>> entry =
              sortedEntries[index];
          DateTime date = entry.key;
          List<OrderCompositionEntity> compositionsForDate = entry.value;

          // Build composition card for each date and its list of compositions
          return buildCompositionCard(compositionsForDate, date, isMobile);
        },
      ),
    );
  }

  /// Widget that builds a card representing a composition for a specific date.
  ///
  /// The card consists of a BasicContainer with a Column as its child.
  /// The Column includes a BasicText displaying the date and a list of
  /// Row widgets representing the order compositions for that date.
  ///
  /// Parameters:
  ///   - [compositionsForDate]: The list of order compositions for a specific date.
  ///   - [date]: The date for which the compositions are made.
  ///   - [isMobile]: Whether the app is running on a mobile device.
  static Widget buildCompositionCard(
      List<OrderCompositionEntity> compositionsForDate,
      DateTime date,
      bool isMobile) {
    // Padding for the card.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Basic container for the card.
      child: BasicContainer(
        child: Column(
          // Align the cross axis to the start.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic text displaying the date.
            BasicText(
              title: '${date.year}/${date.month}/${date.day}',
            ),
            // Map each composition to a row widget and add them to a list.
            ...compositionsForDate.map(
                (composition) => buildCompositionRow(composition, isMobile)),
          ],
        ),
      ),
    );
  }

  /// Widget that builds a row representing an order composition.
  ///
  /// The row consists of an image of the composed clothes, details of the
  /// clothes, and the total price of the composition.
  ///
  /// Parameters:
  ///   - [composition]: The order composition to build the row for.
  ///   - [isMobile]: Whether the app is running on a mobile device.
  ///
  /// Returns:
  ///   A Row widget containing the image, details and total price of the
  ///   order composition.
  static Widget buildCompositionRow(
      OrderCompositionEntity composition, bool isMobile) {
    return Column(
      children: [
        Row(
          children: [
            // Padding for the image.
            Padding(
              padding: const EdgeInsets.all(8.0),
              // Image of the composed clothes.
              child: SizedBox(
                height: isMobile ? 75 : 200,
                width: isMobile ? 75 : 200,
                child: CachedNetworkImage(
                  imageUrl: composition.clothesComp!.clothesPhoto!,
                  fit: BoxFit.fill,
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            // Details of the composed clothes.
            buildCompositionDetails(composition),
            // Fills the remaining space in the row.
            const Spacer(),
            // Total price of the order composition.
            buildCompositionQuantity(composition),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(thickness: 3),
        ),
      ],
    );
  }

  /// Widget that displays the details of an order composition.
  ///
  /// Displays the name of the clothes, barcode, size, color and gender.
  ///
  /// Parameters:
  ///   - [composition]: The order composition to display the details for.
  ///
  /// Returns:
  ///   A [Column] widget containing the details of the order composition.
  static Widget buildCompositionDetails(OrderCompositionEntity composition) {
    return Column(
      children: [
        // Display the name of the clothes.
        BasicText(
          title: composition.clothesComp!.nameClothesEn!,
        ),
        // Display the barcode of the clothes.
        CardText(
          title: 'barcode: ${composition.clothesComp!.barcode!}',
        ),
        // Display the size of the clothes.
        CardText(
          title: 'size: ${composition.sizeClothes!.nameSize}',
        ),
        // Display the color of the clothes.
        CardText(
          title: 'color: ${composition.colorClothes!.nameColor}',
        ),

        // Display the gender of the clothes.
        CardText(
          title:
              'gender: ${composition.clothesComp!.typeClothes!.categoryClothes!.nameCategory}',
        ),
        CardText(
          title: 'order number: ${composition.orderId!.numberOrder}',
        ),
      ],
    );
  }

  /// Builds a [Widget] that displays the quantity of an [OrderCompositionEntity].
  ///
  /// The widget is a [Column] containing a [CardText] widget displaying the
  /// quantity of the composition.
  ///
  /// Parameters:
  ///   - [composition]: The order composition to display the quantity for.
  ///
  /// Returns:
  ///   A [Column] widget containing a [CardText] widget displaying the
  ///   quantity of the order composition.
  static Widget buildCompositionQuantity(OrderCompositionEntity composition) {
    // The widget is a Column with the main axis alignment set to end,
    // which aligns its children to the end of the column.
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // The children of the Column are a CardText widget displaying the
      // quantity of the composition.
      children: [
        // The title of the CardText widget is the composition's quantity.
        CardText(
          title: 'quantity: ${composition.quantity}',
        ),
      ],
    );
  }
}
