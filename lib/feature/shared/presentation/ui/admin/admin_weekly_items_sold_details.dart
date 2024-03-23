import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/text/card_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_clothes_weekly_items_by_week.dart';

class AdminWeeklyItemsSoldDetails extends StatefulWidget {
  const AdminWeeklyItemsSoldDetails({Key? key}) : super(key: key);

  @override
  State<AdminWeeklyItemsSoldDetails> createState() =>
      _AdminWeeklyItemsSoldDetailsState();
}

class _AdminWeeklyItemsSoldDetailsState
    extends State<AdminWeeklyItemsSoldDetails> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header widget
            const Row(
              children: [
                Expanded(
                  child: Header(
                    title: 'weekly items sold overview',
                  ),
                ),
              ],
            ),
            // Line chart

            // Search bar and filters

            const Row(
              children: [AdminWeeklySoldItemsByWeek()],
            ),
            // Active users table
            Row(
              // A horizontally expanding widget that contains a table widget
              children: [
                Expanded(
                  // Expands to fill available horizontal space
                  child: BlocProvider<RemoteOrderCompBloc>(
                    create: (context) => service()..add(const GetOrderComp()),
                    child:
                        BlocBuilder<RemoteOrderCompBloc, RemoteOrderCompState>(
                      builder: (_, state) {
                        switch (state.runtimeType) {
                          case RemoteOrderCompLoading:
                            return const Center(
                                child: CircularProgressIndicator());
                          case RemoteOrderCompDone:
                            return _buildWeeklyOrdersCompositions(
                                state, isMobile);

                          case RemoteOrderCompError:
                            return const Text("error");
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
  Widget _buildWeeklyOrdersCompositions(
      RemoteOrderCompState state, bool isMobile) {
    // List of order compositions for the week
    List<OrderCompositionEntity> compositions = state.compositions!;

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
          return _buildCompositionCard(compositionsForDate, date, isMobile);
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
  Widget _buildCompositionCard(List<OrderCompositionEntity> compositionsForDate,
      DateTime date, bool isMobile) {
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
                (composition) => _buildCompositionRow(composition, isMobile)),
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
  Widget _buildCompositionRow(
      OrderCompositionEntity composition, bool isMobile) {
    return Row(
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
        _buildCompositionDetails(composition),
        // Fills the remaining space in the row.
        const Spacer(),
        // Total price of the order composition.
        _buildCompositionTotalPrice(composition),
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
  Widget _buildCompositionDetails(OrderCompositionEntity composition) {
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
      ],
    );
  }

  /// Widget that displays the total price of an order composition.
  ///
  /// The total price is calculated by multiplying the price of the clothes
  /// and the quantity of the order composition.
  ///
  /// Parameters:
  ///   - [composition]: The order composition to calculate the total price for.
  ///
  /// Returns:
  ///   - A [Column] widget displaying the total price.
  Widget _buildCompositionTotalPrice(OrderCompositionEntity composition) {
    // Create a [Column] widget to display the total price.
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Display the total price with the format 'priceClothes ₽ X quantity'.
        CardText(
          title:
              '${composition.clothesComp!.priceClothes}₽ X ${composition.quantity}',
        ),
      ],
    );
  }
}
